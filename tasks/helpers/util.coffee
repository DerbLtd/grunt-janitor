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

Array.prototype.equals = (array) ->
  return false if not array # if the other array is a falsy value, return
  return false if @length isnt array.length # compare lengths - can save a lot of time

  for item, index in @
    if item instanceof Array and array[index] instanceof Array # Check if we have nested arrays
      if not item.equals(array[index]) # recurse into the nested arrays
        return false
    else if this[index] != array[index]
      return false # Warning - two different object instances will never be equal: {x:20} != {x:20}
  true

writeObj = ( obj ) ->
  for key, value of obj
    grunt.log.writeln key, value
  grunt.log.write "\n"

# export the modules
module.exports =
  regexEscape: regexEscape
  regexGet: regexGet
  isArray: isArray
  writeObj: writeObj