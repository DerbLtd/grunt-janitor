'use strict'
test = require './../test'
report = require './../report'
grunt = require 'grunt'

test.registerTest( 'default:present', 'is the following string/regex present', ( regexOrString )->
  this.file.getContentByLine()
)

test.registerTest( 'default:absent', 'is the following string/regex absent', ( regexOrString, severity )->
  lineNrs = this.file.findLineNumbers( regexOrString )
  if lineNrs
    report.set( 'absent' + regexOrString, severity, this.file, lineNrs, 'The string ' +  regexOrString + ' should be absent' )
)