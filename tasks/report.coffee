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
  grunt.log.writeln ''
  grunt.log.writeln "The results are in:"
  grunt.log.writeln ''

  for test in _result.tests
    grunt.log.writeln "- ", test

module.exports =
  set: set
  prettyPrint: prettyPrint