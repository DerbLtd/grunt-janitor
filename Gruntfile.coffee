#
# * grunt-janitor
# * https://github.com/kevin/grunt-janitor
# *
# * Copyright (c) 2014 Kevin Smets
# * Licensed under the MIT license.
# 
"use strict"
module.exports = (grunt) ->
  grunt.initConfig
    jshint:
      all: [
        "Gruntfile.js"
        "tasks/*.coffee"
        "<%= nodeunit.tests %>"
      ]
      options:
        jshintrc: ".jshintrc"

    clean:
      tests: ["tmp"]

  # Configuration to be run (and then tested).
    janitor:
      sass:
        options: {
          tests:
#            'default:present': ['.touch0101']
            'default:absent': ['.touch0108', 'error']
        }
        files: [
          expand: true
          src: ["test.sass"]
          cwd: "test/fixtures/"
        ]

  # Unit tests.
    nodeunit:
      tests: ["test/*_test.js"]

  grunt.loadTasks "tasks"
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-nodeunit"

  #  grunt.registerTask('test', ['clean', 'janitor', 'nodeunit']);
  grunt.registerTask "test", [
#    "clean"
    "janitor:sass"
  ]
  return