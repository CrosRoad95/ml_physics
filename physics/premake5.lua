project "physics"
	language "C"
	kind "SharedLib"
	targetname "physics"

	vpaths {
		["Headers/*"] = "**.h",
		["Sources"] = "**.cpp",
		["*"] = "premake5.lua"
	}

	files {
		"premake5.lua",
		"*.h",
		"*.cpp"
	}

	links { "BulletCollision", "BulletDynamics", "LinearMath" }