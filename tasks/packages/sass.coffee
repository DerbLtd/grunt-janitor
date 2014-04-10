'use strict'

test = require './../test'
grunt = require 'grunt'

# ( name, description, fn, options )
test.registerTest( 'noId', 'Dissalow ids in ', ()->
  grunt.log.write 'noid is being called', this
  return false
)
#    'testFromJanitor', 'a-ok', ()->
#    grunt.log.write('execute test testFromJanitor', "\n")
#    grunt.log.write( this.getFiletype() )
