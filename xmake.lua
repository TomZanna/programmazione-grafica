add_rules("mode.debug", "mode.release")

add_requires("glfw", "stb", "glm", "assimp")
add_requires("glad", {configs = {api = "gl=4.3", profile = "core", generator = "c"}})
add_includedirs("utils/")

add_defines("PROJECT_ROOT_DIR=\"$(projectdir)/\"")

includes("src/**/xmake.lua")

task("format")
    on_run(function ()
        import("core.base.option")
        import("lib.detect.find_tool")
        
        local tool = find_tool("clang-format")
        if not tool then
            raise("clang-format not found!")
        end
        
        local files = option.get("files") or {"**/*.cpp", "**/*.h"}
        for _, pattern in ipairs(files) do
            local filelist = os.files(pattern)
            for _, file in ipairs(filelist) do
                os.execv(tool.program, {"-i", file})
                print("Formatting file:", file)
            end
        end
    end)
    
    set_menu {
        usage = "xmake format [options]",
        description = "Format code files",
        options = {
            {'f', "files", "vs", nil, "File patterns to format"}
        }
    }
