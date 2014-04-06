'use strict'

module.exports = ( grunt ) ->

  filinator = require './file'

  log = (message) ->
    grunt.log.write message + "\n"

  grunt.registerMultiTask 'janitor', 'Code pattern checker for grunt. Cleanup on isle 4!', () ->
    options = @options(
      punctuation: "."
      separator: ", "
    )

    this.files.forEach ( path )->
      file = filinator.file path.src
      find = filinator.find file, 'find it'