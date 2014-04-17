"use strict"
grunt = require 'grunt'
util = require './util'

_conf =
  files:
    prefix: 'jFid-'
    autoIncrement: 0
  tests:
    prefix: 'jTid-'
    autoIncrement: 0
  results:
    prefix: 'jRid-'
    autoIncrement: 0
  severities:
    prefix: 'jSid-'
    autoIncrement: 0
    mapping: {}

_result =
  files: {}
  tests: {}
  severities: {}
  results: {}

_getLine = ( lineNumber, file )->
  o =
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

_getSeverity = ( severity ) ->
  return _conf.severities.mapping[severity] if _conf.severities.mapping[severity]
  id = _getResultId( 'severities' )
  _conf.severities.mapping[severity] =
    name: id
  id

_registerResult = ( file, test, lineNr, severity ) ->
  idSeverity = _getSeverity( severity )
  _markResult( 'tests', test.id )
  _markResult( 'files', file.id() )
  _markResult( 'severities', idSeverity )
  id = _getResultId()
  _result.results[ id ] =
    file: file.id()
    test: test.id
    severity: idSeverity
    line: lineNr
    content: if lineNr then file.getLine( lineNr ) else ''
#  grunt.log.writeln  _result.results[ id ]['file']
#  grunt.log.writeln  _result.results[ id ]['test']
#  grunt.log.writeln  _result.results[ id ]['line']
#  grunt.log.writeln  _result.results[ id ]['content']
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
  if util.isArray lineNumbers
    for lineNumber in lineNumbers
      _registerResult file, test, lineNumber, severity
  else if !isNaN(parseFloat(lineNumbers)) && isFinite(lineNumbers)
    _registerResult file, test, lineNumber, severity
  else
    _registerResult file, test, false, severity
  return true

prettyPrint = () ->
  grunt.log.write "\n\n"
  grunt.log.write "Test results:", "\n"
  grunt.log.write "\t", "currently working on", "\n"
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