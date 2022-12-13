local package = {}
package.name = "unicorntool"
package.desc = "Command-line utility for installing a package table from a file"
package.version = "1.0.0"
package.instdat = {}
package.instdat.repo_owner = "unicornpkg"
package.instdat.repo_name = "cli"
package.instdat.repo_ref = "v1.0.0"
package.instdat.filemaps = {}
package.instdat.filemaps["unicorntool/init.lua"] = "/bin/unicorntool.lua"
package.instdat.filemaps["unicorntool/help.txt"] = "/usr/share/help/unicorntool.txt"
package.instdat.filemaps["unicorntool/completions.lua"] = "/startup/completion-unicorntool.lua"
package.rel = {}
package.rel.depends = {"unicornpkg"}
package.pkgType = "com.github"
package.unicornSpec = "v1.0.0"

return package
