`#! /usr/bin/env node
` #coffee
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
  stat: true #mark

#-------------------------------------------------------------------------------

key = (subtitle, command) ->
  if @template
    subtitle: subtitle
    arg: command
  else subtitle: '' #valid: false

list = (item) ->
  @template = matches?[0][item]?
  @file = cache?["#{TEMPLATES}/#{item}"].match /FILE/

  keys = if @file
    alt: key "Edit template", "open '#{item}'"
    cmd: key "Reveal in Finder", "open -R '#{item}'"
    ctrl: subtitle: ''
  else {} # Folder
  keys.alt ?= keys.cmd ?= key "Open in Finder", "open '#{item}'"
  #shift:
  keys.ctrl = key "Trash template", "mv -f '#{item}' ~/.Trash"

  #uid: item.toLowerCase()
  title: item
  autocomplete: item
  type: 'file'#:skipcheck
  arg: item
  mods: keys
  icon:
    type: 'fileicon' #filetype
    path:
      if @template then "#{TEMPLATES}/#{item}"
      else unless @file ? ~item.indexOf '.' then '/bin' else null

items = [list query]
{cache, matches} = glob "*#{query}*", options, (err, templates) ->
  for template in templates
    if query.match ///^#{template}$///i
      items.pop list query

    items.push list template

  console.log JSON.stringify {items}
