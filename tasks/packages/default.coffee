'use strict'
test = require './../test'
report = require './../report'
grunt = require 'grunt'

test.registerTest( 'default:includes', 'is the following string/regex present', ( regexOrString )->
  this.file.getContentByLine()
)

test.registerTest( 'default:excludes', 'is the following string/regex excluded', ( regexOrString, severity )->
  lineNrs = this.file.findLineNumbers( regexOrString )
  if lineNrs
    report.set( this.test, this.file, severity, lineNrs, 'The string should be excluded' )
)

test.registerTest( 'default:doneSingle', 'just a test', ( )->
  report.set( this.test, this.file, 'error', false, 'yeah babay yeah baby yeah' )
)