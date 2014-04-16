"use strict"
grunt = require 'grunt'

_result =
  tests: {}

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

set = ( key, severity, file, lineNumbers, description ) ->
  if !_result.tests[key]?
    _result.tests[key] =
      description: description
      severity: severity
      locations: []
  a = _getLines( lineNumbers, file )
  _result.tests[key]['locations'] = _result.tests[key]['locations'].concat a

prittyPrint = () ->
  grunt.log.write "\n\n"
  grunt.log.write "Test results:", "\n"
  for key, value of _result.tests
    grunt.log.write "\t" + value.severity, "'" + key + "' ", value.description, "\n"
    for loc in value.locations
      grunt.log.write "\tfile: \t", loc.filepath + '(' + loc.number + '): ', loc.content, "\n"
  grunt.log.write "\n\n"

module.exports =
  set: set
  prittyPrint: prittyPrint