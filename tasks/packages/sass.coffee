'use strict'

test = require './../test'

# ( name, description, fn, options )
test.registerTest( 'noId', 'Dissalow ids in ', ()->
  return false
)
#    'testFromJanitor', 'a-ok', ()->
#    grunt.log.write('execute test testFromJanitor', "\n")
#    grunt.log.write( this.getFiletype() )
