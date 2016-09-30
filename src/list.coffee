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

key = (subtitle, arg) ->
  if @template
    #valid: true
    subtitle: subtitle
    arg: arg
  else subtitle: ''

list = (item) ->
  @template = matches?[0][item]?
  @file = cache?["#{TEMPLATES}/#{item}"].match /FILE/

  #uid: item.toLowerCase()
  title: item
  autocomplete: item
  type: 'file'#:skipcheck
  arg: item
  mods:
    if @file
      alt: key "Edit template", "edit #{item}"
      cmd: key "Reveal in Finder", "reveal #{item}"
      ctrl: subtitle: ''
    else # Folder
      alt: key "Open in Finder", "edit #{item}"
      cmd: key "Open in Finder", "open #{item}"
      ctrl: subtitle: ''
  icon:
    type: 'fileicon' #filetype
    path:
      if @template then "#{TEMPLATES}/#{item}"
      else unless @file then '/bin' else null

items = [list query]
{cache, matches} = glob "*#{query}*", options, (err, templates) ->
  for template in templates #sync "*#{query}*", options
    if query.match ///^#{template}$///i
      items.pop list query

    items.push list template

  console.log JSON.stringify {items}
