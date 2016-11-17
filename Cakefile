{execSync, exec} = require 'child_process'
{readFileSync, writeFile, unlink} = require 'fs'
{name, files} = pkg = require './package'#.json
{title} = require 'change-case'
plist = require 'plist' #'../alfred-link/lib/plist-transform'

#-------------------------------------------------------------------------------

option '-w', '--workflow', "Also include npm postinstall modifications."
task 'plist',"Update info.plist from package.json", (options) ->

  fix = (obj) -> # FIXME https://github.com/TooTallNate/plist.js/issues/75
    for key in Object.keys obj
      val = obj[key]
      if val is null or val is undefined
        obj[key] = ''
      else if Array.isArray val
        obj[key] = val.map fix
      else if typeof val is 'object'
        obj[key] = fix val
    return obj
  info = fix plist.parse readFileSync '.info.plist','utf8'

  info.category = category if category = pkg.config?.category

  name = title pkg.name.replace /// (^alfred|#{info.category}) ///ig,''
  info.name ?= pkg.config?.name ? name

  if options.workflow # Packal
    info.version = pkg.version
    info.description = pkg.description
    info.webaddress = homepage if homepage = pkg.homepage
    info.createdby = author if author = pkg.author?.name

  username = pkg.author?.name.replace( /\s+/g,'').toLowerCase()
  info.bundleid ?= pkg.config?.bundleid ? "com.#{username}.#{pkg.name}"

  info.variables ?= pkg.config?.variables ? {}
  info.variables.PATH = execSync("tr '\n' : < /etc/paths").toString()

  info.readme ?= pkg.config?.readme ? pkg.description
  if info.readme is true
    info.readme = readFileSync 'README.md','utf8'

  console.log plist.build info

task 'packal',"Package workflow for distribution on packal.org", ->
  {name} = update workflow: true
  spawn 'src/packal.zsh', [name]
