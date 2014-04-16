"use strict"
grunt = require("grunt")

# escape the given string to a proper regex format
regexEscape = ( str ) ->
  str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&")

regexGet = ( variable ) ->
  if typeof variable == 'object'
    return variable
  if typeof variable == 'string'
    return new RegExp( regexEscape(variable), 'm')
  false

isArray = ( varName ) ->
  Object.prototype.toString.call( varName ) is "[object Array]"

# export the modules
module.exports =
  regexEscape: regexEscape
  regexGet: regexGet
  isArray: isArray