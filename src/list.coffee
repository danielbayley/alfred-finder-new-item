`#! /usr/bin/env node
`
query = process.argv[2]
TEMPLATES = process.env.TEMPLATES ? "#{process.cwd()}/templates"

ignore = require 'parse-gitignore'
ignored = ignore "#{TEMPLATES}/.gitignore"

glob = require 'glob'
options =
  cwd: TEMPLATES
  nocase: true
  noglobstar: true
  dot: true
  ignore: ignored.concat ['.DS_Store']
  stat: true

#-------------------------------------------------------------------------------

key = (subtitle, command) ->
  if @template?
    subtitle: subtitle
    arg: command
  else subtitle: ''

list = (item) ->
  @template = templates?.cache["#{TEMPLATES}/#{item}"]
  @file = @template?.match /FILE/

  keys = if @file
    alt: key "Edit template", "open '#{item}'"
    cmd: key "Reveal in Finder", "open -R '#{item}'"
    ctrl: subtitle: ''
  else {} # Folder
  keys.alt ?= keys.cmd ?= key "Open in Finder", "open '#{item}'"

  keys.ctrl = key "Trash template", "mv -f '#{item}' ~/.Trash"

  title: item
  autocomplete: item
  type: 'file'
  arg: item
  mods: keys
  icon:
    type: 'fileicon'
    path:
      if @template? then "#{TEMPLATES}/#{item}"
      else unless @file ? ~item.indexOf '.' then '/bin' else null

items = [list query]
templates = glob "*#{query}*", options, ->
  templates?.found.map (template) ->
    if ///^#{template}$///i.test query
      items.pop list query
    items.push list template

  console.log JSON.stringify {items}
