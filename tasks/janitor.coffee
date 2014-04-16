'use strict'

module.exports = ( grunt ) ->

  filinator = require './file'
  test = require './test'
  report = require './report'

  loadFile = (path)->
    if !grunt.file.exists path
      return false
    require path
    true

  getPackages = (tests)->
    packages = []
    set = {}
    for key of tests
      name = getPackageNameFromTest key
      if set[name] == true
        continue
      set[name] = true
      packages.push name
    packages

  getPackageNameFromTest = ( test )->
    a = test.split ':'
    a[0]

  loadPackage = ( thaPackage, packageDir )->
    for dir in packageDir
      path = dir + '/' + thaPackage + '.coffee'
      if loadFile(path)
        break

  loadPackages = ( tests, packageDir )->
    packages = getPackages tests
    for thapack in packages
      loadPackage thapack, packageDir


  grunt.registerMultiTask 'janitor', 'Code pattern checker for grunt. Cleanup on isle 4!', () ->
    options = @options(
      packageDir: []
      tests: {}
    )

    # load packages
    options.packageDir.push __dirname + '/packages/'
    loadPackages( options.tests, options.packageDir )

    # iterate files
    this.files.forEach ( path )->
      file = filinator.file path.src[0]
      test.executeTests file, options

    # print result
    report.prettyPrint()