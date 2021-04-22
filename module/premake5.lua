project "ml_physics"
	language "C"
	kind "SharedLib"
	targetname "ml_physics"

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