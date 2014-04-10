'use strict'

module.exports = ( grunt ) ->

  filinator = require './file'
  test = require './test'

  loadTestPackage = ( name ) ->
    if grunt.file.exists name
      require name
      return true
    pathPackage = __dirname + '/packages/' + name + '.coffee'
    if grunt.file.exists pathPackage
      require pathPackage
      return true
    false

  grunt.registerMultiTask 'janitor', 'Code pattern checker for grunt. Cleanup on isle 4!', () ->
    options = @options(
      packages: ['sass']
      tests: undefined
    )

    # load packages
    for testPackage in options.packages
      loadTestPackage testPackage

    # iterate files
    this.files.forEach ( path )->
      file = filinator.file path.src
      test.executeTests file, options.tests