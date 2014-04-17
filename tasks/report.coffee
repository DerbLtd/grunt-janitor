"use strict"
grunt = require 'grunt'
util = require './util'

_conf =
  files:
    prefix: 'jfid-'
    autoIncrement: 0
  tests:
    prefix: 'jtid-'
    autoIncrement: 0
  results:
    prefix: 'jrid-'
    autoIncrement: 0

_result =
  files: {}
  tests: {}
  results: {}

_getLine = ( lineNumber, file )->
  o =
    filename: file.getFileName()
    filepath: file.getFilePath()
    number: lineNumber
    content: file.getLine(lineNumber)

_getLines = ( lineNumbers, file )->
  a = []
  if typeof lineNumbers == 'number'
    a.push( _getLine(lineNumbers, file) )
  else if typeof lineNumbers == 'object'
    for val in lineNumbers
      a.push( _getLine(val, file) )
  a

_getLocations = ( file, lineNumbers )->
  return _getLines( )

_getResultId = ( type )->
  if !_conf[type]?
    return false
  _conf[type]['autoIncrement'] = _conf[type]['autoIncrement'] + 1
  _conf[type]['prefix'] + _conf[type]['autoIncrement']

_markResult = ( type, id )->
  if !_conf[type]? || !_result[type]?
    return false
  if !_result[type][id]?
    return false
  if !_result[type][id]['marks']?
    _result[type][id]['marks'] = 1
  else
    _result[type][id]['marks'] = _result[type][id]['marks'] + 1
  id

registerTest = (name, variation, args)->
  id = _getResultId( 'tests' )
  _result.tests[ id ] =
    name: name
    variation: variation
    arguments: args
  id

registerFile = ( name, filetype, path )->
  id = _getResultId( 'files' )
  _result.files[ id ] =
    name: name
    filetype: filetype
    path: path
  id

set = ( test, file, severity, lineNumbers, description ) ->
  _markResult( 'tests', test.id )
  _markResult( 'files', file.id() )
#  grunt.log.writeln file.id
  return true
  key = test.name
  if test.variation?
    key = key + ":" + test.variation
  if !_result.tests[key]?
    _result.tests[key] =
      description: description
      severity: severity
      locations: []
  a = _getLines( lineNumbers, file )
  _result.tests[key]['locations'] = _result.tests[key]['locations'].concat a

prettyPrint = () ->
  grunt.log.write "\n\n"
  grunt.log.write "Test results:", "\n"
  grunt.log.write "currently working on", "\n"
  return true
  for key, value of _result.tests
    grunt.log.write "\t" + value.severity, "'" + key + "' ", value.description, "\n"
    for loc in value.locations
      grunt.log.write "\tfile: \t", loc.filepath + '(' + loc.number + '): ', loc.content, "\n"
    grunt.log.write "\n"
  grunt.log.write "\n\n"

module.exports =
  set: set
  prettyPrint: prettyPrint
  registerTest: registerTest
  registerFile: registerFile