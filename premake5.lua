-- stolen from mta source code
-- Add buildactions to path

-- Set CI Build global
local ci = os.getenv("CI")
if ci and ci:lower() == "true" then
	CI_BUILD = true
else
	CI_BUILD = false
end
GLIBC_COMPAT = os.getenv("GLIBC_COMPAT") == "true"

workspace "ml_physics"
	configurations {"Debug", "Release", "Nightly"}

	platforms { "x86", "x64"}
	if os.host() == "macosx" then
		removeplatforms { "x86" }
	end

	targetprefix ""

	location "Build"
	startproject "test"

	cppdialect "C++17"
	characterset "MBCS"
	pic "On"
	symbols "On"

	dxdir = os.getenv("DXSDK_DIR") or ""
	includedirs {
		"vendor",
	}

	-- Helper function for output path
	buildpath = function(p) return "%{wks.location}/../Bin/"..p.."/" end
	copy = function(p) return "{COPY} %{cfg.buildtarget.abspath} \"%{wks.location}../Bin/"..p.."/\"" end

	if GLIBC_COMPAT then
		filter { "system:linux" }
			includedirs "/compat"
			linkoptions "-static-libstdc++ -static-libgcc"
			forceincludes  { "glibc_version.h" }
		filter { "system:linux", "platforms:x86" }
			libdirs { "/compat/x86" }
		filter { "system:linux", "platforms:x64" }
			libdirs { "/compat/x64" }
	end

	filter "platforms:x86"
		architecture "x86"
	filter "platforms:x64"
		architecture "x86_64"

	filter "configurations:Debug"
		defines { "MTA_DEBUG" }
		targetsuffix "_d"

	filter "configurations:Release or configurations:Nightly"
		optimize "Speed"	-- "On"=MS:/Ox GCC:/O2  "Speed"=MS:/O2 GCC:/O3  "Full"=MS:/Ox GCC:/O3

	if CI_BUILD then
		filter {}
			defines { "CI_BUILD=1" }

		filter { "system:linux" }
			linkoptions { "-s" }
	end

	filter {"system:windows", "configurations:Nightly", "kind:not StaticLib"}
		os.mkdir("Build/Symbols")
		linkoptions "/PDB:\"Symbols\\$(ProjectName).pdb\""

	filter "system:windows"
		toolset "v142"
		staticruntime "On"
		defines { "WIN32", "_WIN32", "_WIN32_WINNT=0x601", "_MSC_PLATFORM_TOOLSET=$(PlatformToolsetVersion)" }
		buildoptions { "/Zc:__cplusplus" }
		includedirs {
			path.join(dxdir, "Include")
		}
		libdirs {
			path.join(dxdir, "Lib/x86")
		}

	filter {"system:windows", "configurations:Debug"}
		runtime "Release" -- Always use Release runtime
		defines { "DEBUG" } -- Using DEBUG as _DEBUG is not available with /MT

	filter {}
		group "Module"
			include "module"

		group "Test"
			include "test"

		group "Vendor"
			include "bulletphysics3d/BulletDynamics"
			include "bulletphysics3d/BulletCollision"
			include "bulletphysics3d/LinearMath"
