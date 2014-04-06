"use strict"
grunt = require("grunt")

# get the extension of the given path DUMB-ASS
_getExtension = ( path ) ->
  path = path.toString()
  path.substr( path.lastIndexOf(".") + 1, path.length )

# escape the given string to a proper regex format
_escapeRegex = ( str ) ->
  str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&")

# convert to file
file = ( path )->
  grunt.log.write 'file called: ' + path + "\n"

# find
find = ( file, searchfor ) ->
  grunt.log.write 'find called: ' + searchfor + "\n"

# export the modules
module.exports =
  file: file
  find: find
