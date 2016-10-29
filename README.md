[![badge][npm]][package]

Finder New Item _[Alfred]_ [workflow]
=====================================
Swiftly create new items in Finder with support for [templates](#templates).

<img width="600px" src="https://media.githubusercontent.com/media/danielbayley/alfred-finder-new-item/master/demo.gif" alt="demo"></img>  
\* Demo using the _[mnml]_ Alfred [theme].

Templates
---------
Templates are sourced from the workflow itself by default, but this can be overriden by a `TEMPLATES` [environment variable] specifying an alternative folder path.

[Symbolic links] at the root level of the templates directory will be followed such that the original item is copied.

If the selected template would replace an existing item, the two will be compared using your favourite [diff tool].

The workflow will respect a `.gitignore` file in the templates directory, which can itself also be used as a template.

<kbd>⌥</kbd> select to edit template.  
<kbd>⌘</kbd> select to reveal original template.

Install
-------
This workflow requires [Node].js (easily available with _[Homebrew]_) and [Alfred] 3 with the paid _[Powerpack]_ upgrade.

~~~ sh
brew install node
npm install -g alfred-finder-new-item
~~~

License
-------
[MIT] © [Daniel Bayley]

[MIT]:                    LICENSE.md
[Daniel Bayley]:          https://github.com/danielbayley

[alfred]:                 http://alfredapp.com
[mnml]:                   https://github.com/danielbayley/alfred-mnml-light
[theme]:                  http://alfredapp.com/help/appearance
[powerpack]:              https://alfredapp.com/powerpack
[workflow]:               http://alfredapp.com/workflows
[packal]:                 https://packal.org/workflow/finder-new-item
[awm]:                    https://github.com/jonathanwiesel/awm

[npm]:                    https://img.shields.io/npm/v/alfred-finder-new-item.svg?style=flat-square
[package]:                https://npmjs.com/package/alfred-finder-new-item
[node]:                   https://nodejs.org
[homebrew]:               http://brew.sh

[environment variable]:   http://alfredapp.com/help/workflows/script-environment-variables
[symbolic links]:         https://en.wikipedia.org/wiki/Symbolic_link
[diff tool]:              http://git-tower.com/blog/diff-tools-mac
