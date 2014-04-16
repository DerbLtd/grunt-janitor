'use strict'
test = require './../test'
report = require './../report'
grunt = require 'grunt'

printObj = ( obj )->
  for key, value of obj
    grunt.log.write key, "\n"

test.registerTest( 'sass:noId', 'Dissalow ids in ', ()->
  grunt.log.write "\n", 'test: noId'
  report.set( 'noid' )
  grunt.log.write this.file + "\n"
)

test.registerTest( 'sass:noComments', 'Dissalow comments', ( qMark )->
  grunt.log.write "\n", 'test: noComments'
  grunt.log.write "\n", qMark, "\n"
)

test.registerTest( 'tmpPrintTest', 'Dissalow comments', ()->
  report.prittyPrint()
)