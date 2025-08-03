-- flatbuffers/src/premake5.lua

-- [ WORKSPACE CONFIGURATION ] --
workspace "flatbuffers"
	location "./_temp"
	configurations { "Debug", "Release" }
	platforms { "x64" }
	startproject "fpsgame"

	----------------------------------
	-- [ COMPILER / LINKER CONFIG ] --
	----------------------------------
  
  systemversion "latest"
	--flags "FatalWarnings" -- /WX (warnings are errors)
	warnings "Extra" -- /W4
	architecture "x64"
	rtti "Off"
	vectorextensions "AVX"
	floatingpoint "Fast"

	-- Filtered options
	filter "configurations:Debug"
		defines { "DEBUG" } 
		symbols "On"
	filter "configurations:Release" 
		defines { "NDEBUG" } 
		optimize "Speed" 
		linktimeoptimization "On"
		flags { "NoBufferSecurityCheck" }

	filter {} -- done with filter, must be closed

	-------------------------------
	-- [ PROJECT CONFIGURATION ] --
	-------------------------------
	project "flatc"
		kind "ConsoleApp"
		language "C++"
		cppdialect "C++20"
		--targetdir ("%{prj.location}/bin/%{cfg.platform}/%{cfg.buildcfg}")
		--objdir "%{prj.location}/obj/%{prj.name}/%{cfg.platform}/%{cfg.buildcfg}"

		local srcDir = "./"
		local incDir = "../include/"
		local grpcDir = "../grpc"

		files
		{
			incDir .. "**.h",
			incDir .. "**.hpp",
			incDir .. "**.inl",
			incDir .. "**.cc",
			
			srcDir .. "**.h",
			srcDir .. "**.c",
			srcDir .. "**.cpp",

			grpcDir .. "/src/compiler/**.h",
			grpcDir .. "/src/compiler/**.cc",
		}

		removefiles { srcDir .. "flathash.cpp" }

		includedirs { incDir, grpcDir }