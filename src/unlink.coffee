`#! /usr/bin/env node
` #coffee
{unlink} = require 'fs'

resolve = require 'resolve-alfred-prefs'

resolve().then (path) ->
  unlink "#{path}/workflows/#{process.env.npm_package_name}"
