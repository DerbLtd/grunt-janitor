"use strict"

grunt = require 'grunt'
util = require './util'

_severities =
  INFO: "info"
  WARNING: "warning"
  ERROR: "error"

_conf =
  files:
    prefix: 'gjFileId-'
    autoIncrement: 0
  tests:
    prefix: 'gjTestId-'
    autoIncrement: 0
  results:
    prefix: 'gjResultId-'
    autoIncrement: 0
  severities:
    prefix: 'gjSeverityId-'
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
  _conf.severities.mapping[severity] =  id
  _result.severities[ id ] =
    name: severity
  id

#_registerResult = ( file, test, lineNr) ->

#  idSeverity = _getSeverity( severity )
#  _markResult( 'tests', test.id )
#  _markResult( 'files', file.id() )
#  _markResult( 'severities', idSeverity )
##  id = _getResultId( 'results' )
#  _result.results[ id ] =
#    file: file.id()
#    test: test.id
#    severity: idSeverity
#    line: lineNr
#    content: if lineNr then file.getLine( lineNr ) else ''
#  grunt.log.writeln  _result.results[ id ]['file']
#  grunt.log.writeln  _result.results[ id ]['test']
#  grunt.log.writeln  _result.results[ id ]['line']
#  grunt.log.writeln  _result.results[ id ]['content']
#  id

registerTest = (name, variation, args)->
  id = _getResultId( 'tests' )
  _result.tests[ id ] =
    name: if variation? then name + ' - ' + variation else name
    test: name
    variation: variation
    arguments: args
  id

registerFile = ( name, filetype, path )->
  id = _getResultId( 'files' )
  _result.files[id] =
    name: name
    filetype: filetype
    path: path

  grunt.log.writeln JSON.stringify(_result)
  id

set = (file, testName, taskOptions, lineNumbers) ->
  test = taskOptions.tests[testName]

  _result.tests[testName] = test

  grunt.log.debug file.getFilePath()

  testCounter = 0
  for lineNumber in lineNumbers
    id = _getResultId( 'results' )

    _result.results[id] =
      file: file.getFilePath()
      test: testName
      severity: taskOptions.tests[testName].severity
      line: lineNumber
      content: file.getLine(lineNumber)


    testCounter++

    grunt.log.debug(
      grunt.log.table(
        [10, 20, 80]
        [test.severity, file.getFileName() + ':' + lineNumber, file.getLine(lineNumber)]
      )
    )

#    _registerResult file, test, lineNumber

prettyPrint = ->

  grunt.log.subhead "Test results:"
  grunt.log.writeln ''

#  for idResult, result of _result.results
#    # Logger
#
#    color = ''
#    switch _result.severities[result.severity]['name']
#      when _severities.INFO then color = 'blue'
#      when _severities.WARNING then color = 'yellow'
#      when _severities.ERROR then color = 'red'
#
#    grunt.log.writeln (_result.severities[result.severity]['name'] + ':')[color], idResult
#    grunt.log.writeln '   file      ', _result.files[result.file]['name'] + " (id:" + result.file + ")"
#    grunt.log.writeln '   test      ', _result.tests[result.test]['name'] + " (id:" + result.test + ")"
#    grunt.log.writeln '   severity  ', _result.severities[result.severity]['name'] + " (id:" + result.severity + ")"
#    grunt.log.writeln '   line      ', result.line
#    grunt.log.writeln '   content    "' + result.content + '"'
#    grunt.log.writeln ''

  # Write the report
  grunt.file.write 'tasks/reportingTool/data/report.json', JSON.stringify(_result, null, '\t')
  grunt.log.verbose.writeln JSON.stringify(_result, null, '\t')

module.exports =
  set: set
  prettyPrint: prettyPrint
  registerTest: registerTest
  registerFile: registerFile