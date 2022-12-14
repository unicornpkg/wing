local package = {}
package.name = "hoof"
package.desc = "Command-line utility for interacting with unicornpkg remotes"
package.version = "1.0.1"
package.instdat = {}
package.instdat.repo_owner = "unicornpkg"
package.instdat.repo_name = "cli"
package.instdat.repo_ref = "v1.0.1"
package.instdat.filemaps = {}
package.instdat.filemaps["hoof/init.lua"] = "/bin/hoof.lua"
package.instdat.filemaps["hoof/help.txt"] = "/usr/share/help/hoof.txt"
package.instdat.filemaps["hoof/completions.lua"] = "/startup/completion-hoof.lua"
package.rel = {}
package.rel.depends = {"unicornpkg"}
package.pkgType = "com.github"
package.unicornSpec = "v1.0.0"

return package
