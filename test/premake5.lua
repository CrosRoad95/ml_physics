project "test"
	language "C"
	kind "ConsoleApp"
	targetname "test"

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