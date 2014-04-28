'use strict'

module.exports = ( grunt ) ->

  filinator = require './helpers/file'
  test = require './helpers/test'
  report = require './helpers/report'

  grunt.registerMultiTask 'janitor', 'Code pattern checker for grunt. Cleanup on aisle 4!', () ->
    options = @options(
      packageDir: []
      tests: {}
    )

    # iterate files
    this.files.forEach ( path )->
      file = filinator.file path.src[0]
      test.executeTests file, options

    # print result
    report.prettyPrint()