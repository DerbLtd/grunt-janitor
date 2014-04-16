'use strict'
test = require './../test'
report = require './../report'
grunt = require 'grunt'

test.registerTest( 'coffee:usestrict', 'lorem ipsum ', ()->
  grunt.log.write this.file + "\n"
)