#
#   all the tests stuff my dear old chap
#
"use strict"
grunt = require "grunt"
report = require './report'
util = require './util'

_tests = {}

_executeTest = ( testname, variation, testOptions, file, taskOptions ) ->
  if !_tests[ testname ]
    grunt.log.error 'The test ', testname, ' could not be located.', "\n"
    return false
  thisWhomWeCallThis =
    test:
      name: testname
      options: testOptions
      variation: variation
    taskOptions: taskOptions
    file: file
  _tests[testname].fn.apply thisWhomWeCallThis, testOptions

#
# public methods
#

# register a test
# @param  string  key the key for this test
# @param  string  description describe the test
# @param  function  fn the test function
# @param  object|undefined  options the options for the test
registerTest = ( key, description, fn, options ) ->
  if typeof fn != 'function'
    return false
  _tests[key] =
    fn: fn
    description: description
    options: options
  true

# execute _tests on given file
# @param  object  file  fileObject generated by file.coffee
# @param  array|undefined _tests contains the _tests name to be executed of all if undefined
executeTests = ( file, options ) ->
  tests = options.tests
  for testname, test of tests
    grunt.log.writeln testname
    if util.isArray( test )
      _executeTest testname, false, test, file, options
    else
      for variationName, variation of test
        _executeTest testname, variationName, variation, file, options
  true

# export the modules
module.exports =
  registerTest: registerTest
  executeTests: executeTests
  tests: _tests
