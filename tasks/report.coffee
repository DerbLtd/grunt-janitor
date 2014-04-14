"use strict"
grunt = require 'grunt'

_severities =
  INFO: 'info'
  WARNING: 'Warning'
  ERROR: 'Error'

_result =
  tests: []

set = ( value ) ->
# required params
#   severity: enum stored in this file
#   filename: from file object
#   filepath: from file object
#   line number: from test
#   Description
#
  _result.tests.push value

prettyPrint = () ->
  grunt.log.write "\n"
  grunt.log.write 'printing the test results', "\n"
  grunt.log.write 'oooh you sooo pretty love you long time', "\n"
  for test in _result.tests
    grunt.log.write "\t", test, "\n"

module.exports =
  set: set
  prettyPrint: prettyPrint