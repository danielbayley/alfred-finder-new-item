{spawn, execSync} = require 'child_process'
{readFile, readFileSync} = require 'fs'
pkg = require './package'#.json
{title} = require 'change-case'
{parse, build} = require 'plist' #'../alfred-link/lib/plist-transform'
#bundle = require 'copy-node-modules'

#-------------------------------------------------------------------------------

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
#-------------------------------------------------------------------------------

update = (options) ->
  info = fix parse readFileSync '.info.plist','utf8' ? {}

  info.category = category if category = pkg.config?.category

  name = title pkg.name.replace /// (^alfred|#{info.category}) ///ig,''
  info.name ?= pkg.config?.name ? name

  if options?.workflow # Packal
    info.version = pkg.versions
    info.description = pkg.description #description if description =
    info.webaddress = homepage if homepage = pkg.homepage
    info.createdby = author if author = pkg.author?.name

  username = pkg.author?.name.replace( /\s+/g,'').toLowerCase()
  info.bundleid ?= pkg.config?.bundleid ? "com.#{username}.#{pkg.name}"

  info.variables ?= pkg.config?.variables ? {}
  info.variables?.PATH = execSync("tr '\n' : < /etc/paths").toString()[0..-2]

  info.readme ?= pkg.config?.readme ? pkg.description
  if info.readme is true
    info.readme = readFileSync 'README.md','utf8'

  #process.env.npm_package_name ?= pkg.name
  #for key of pkg.config
    #process.env["npm_package_config_#{key}"] ?= pkg.config[key]

  return info
#-------------------------------------------------------------------------------

option '-w','--workflow',"Also include npm postinstall modifications."

task 'plist',"Update plist info from package.json", (options) ->
  console.log build update options

task 'packal',"Package workflow for distribution on packal.org", ->
  {name} = update workflow: true
  spawn 'src/packal.zsh', [name]
