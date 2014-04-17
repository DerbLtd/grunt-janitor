"use strict"
grunt = require "grunt"
util = require "./util"
report = require "./report"

# escape the given string to a proper regex format
_escapeRegex = ( str ) ->
  str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&")

# convert to janitor file
file = ( path )->

  _content = undefined
  _contentByLine = undefined
  _fileName = undefined
  _fileType = undefined
  _path = path

  getFileName = () ->
    if _fileName?
      return _fileName
    _fileName = path.substr( path.lastIndexOf("/") + 1, path.length )

  getFilePath = () ->
    return _path

  # get the files content
  getContent = () ->
    if( _content? )
      return _content
    _content = grunt.file.read _path

  # get the files content in an array each item represents a line
  getContentByLine = () ->
    if( _contentByLine? )
      return _contentByLine
    _contentByLine = getContent().split('\n')

  # get the files extension
  getFiletype = () ->
    if ( _fileType )
      return _fileType
    path = _path.toString()
    _fileType = path.substr( path.lastIndexOf(".") + 1, path.length )

  # find the line number of the given regex or string
  findLineNumbers = ( regexOrString )->
    regex = util.regexGet regexOrString
    aContent = getContentByLine()
    aReturn = []
    i = 0
    for line in aContent
      i++
      if regex.test line
        aReturn.push i
    if aReturn.length > 0 then aReturn else false

  # get the contents of the specified line number
  getLine = ( lineNumber )->
    getContentByLine()[ lineNumber - 1 ]

  getId = ()->
    _id

  _id = report.registerFile( getFileName(), getFiletype(), getFilePath() )

  a =
    getContent: getContent
    getContentByLine: getContentByLine
    getFiletype: getFiletype
    getFileName: getFileName
    getFilePath: getFilePath
    getLine: getLine
    findLineNumbers: findLineNumbers
    id: getId


# export the modules
module.exports =
  file: file