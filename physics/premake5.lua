project "physics"
	language "C"
	kind "SharedLib"
	targetname "physics"

	vpaths {
		["Headers"] = {"**.h", "**.hpp"},
		["Sources"] = "**.cpp",
		["*"] = "premake5.lua"
	}

	files {
		"premake5.lua",
		"**.h",
		"**.hpp",
		"**.cpp"
	}

	pchheader "StdInc.h"
	pchsource "StdInc.cpp"

	includedirs { ".", "include", "include/physics", "../" }
	links { "BulletCollision", "BulletDynamics", "LinearMath" }