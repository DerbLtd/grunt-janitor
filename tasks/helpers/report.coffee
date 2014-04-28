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

_result =
  files: {}
  tests: {}
  results: {}

_getLine = ( lineNumber, file )->
  obj =
    number: lineNumber
    content: file.getLine(lineNumber)
  obj

_getLines = ( lineNumbers, file )->
  arr = []
  if typeof lineNumbers == 'number'
    a.push( _getLine(lineNumbers, file) )
  else if typeof lineNumbers == 'object'
    for val in lineNumbers
      a.push( _getLine(val, file) )
  arr

_getResultId = ( type )->
  if !_conf[type]?
    return false
  _conf[type]['autoIncrement'] = _conf[type]['autoIncrement'] + 1
  _conf[type]['prefix'] + _conf[type]['autoIncrement']

registerTest = (test)->
  id = _getResultId( 'tests' )
  grunt.log.debug JSON.stringify(test)
  _result.tests[ id ] = test
  id

registerFile = ( name, fileType, path )->
  id = _getResultId( 'files' )
  _result.files[id] =
    name: name
    fileType: fileType
    path: path
  id

set = (file, testName, taskOptions, lineNumbers) ->
  test = taskOptions.tests[testName]

  testId = registerTest(test)

  grunt.log.debug JSON.stringify(test[0])

  if lineNumbers
    grunt.log.subhead 'file: ' + file.getFilePath()

    for lineNumber in lineNumbers
      # Register the result
      id = _getResultId( 'results' )

      _result.results[id] =
        file: file.getId()
        test: testId
        severity: taskOptions.tests[testName].severity
        line: lineNumber
        content: file.getLine(lineNumber)

      grunt.log.writeln '\tline ' + lineNumber + ': ' + test.severity + ' - ' + test.description
      grunt.log.writeln '\tcontent: ' + file.getLine(lineNumber)
      grunt.log.writeln ''

prettyPrint = ->
  # Write the report
  grunt.file.write __dirname + '/../data/reporter/report.json', JSON.stringify(_result, null, '\t')
  grunt.log.verbose.writeln JSON.stringify(_result, null, '\t')

module.exports =
  set: set
  prettyPrint: prettyPrint
  registerTest: registerTest
  registerFile: registerFile