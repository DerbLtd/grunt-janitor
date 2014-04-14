'use strict'
test = require './../test'
report = require './../report'
grunt = require 'grunt'

test.registerTest( 'noId', 'Dissalow ids in ', ()->
  report.set( 'noid' )
  grunt.log.write this.file + "\n"
)

test.registerTest( 'noComments', 'Dissalow comments', ()->
  report.set( 'noComments' )
)

test.registerTest( 'tmpPrintTest', 'Dissalow comments', ()->
  report.prettyPrint()
)