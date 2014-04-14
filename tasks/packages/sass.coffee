'use strict'
test = require './../test'
report = require './../report'
grunt = require 'grunt'

test.registerTest( 'noId', 'Disallow ids in ', ()->
  report.set( 'noid' )
  grunt.log.write this.file + "\n"
)

test.registerTest( 'noComments', 'Disallow comments', ()->
  report.set( 'noComments' )
)

test.registerTest( 'tmpPrintTest', 'Disallow comments', ()->
  report.prettyPrint()
)