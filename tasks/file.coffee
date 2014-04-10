"use strict"
grunt = require("grunt")

# escape the given string to a proper regex format
_escapeRegex = ( str ) ->
  str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&")

# convert to janitor file
file = ( path )->

  _content = undefined
  _fileType = undefined
  _path = path

  # get the files content
  getContent = () ->
    if( _content? )
      return _content
    _content = grunt.file.read _path

  # get the files extension
  getFiletype = () ->
    if ( _fileType )
      return _fileType
    path = _path.toString()
    _fileType = path.substr( path.lastIndexOf(".") + 1, path.length )

  a =
    getContent: getContent
    getFiletype: getFiletype

# export the modules
module.exports =
  file: file