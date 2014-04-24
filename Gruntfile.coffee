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
            'default:excludes':
              'no-ids': ['#', 'error']
#              'no unbuffered comments': [ /(\/\\*)|(\\*\/)/i, 'error']
#              'no hardcoded colors': [': #', 'bad idea']
#            'default:doneSingle': ['test']
          "testHowitwouldbe":
            "jusftify-noid": # name of the test
              "default:justify": [] # the test function and its parameters
              "chain":  # optional parameter
                "no-id": # test name
                  "default:excludes": [
                    '#',
                    'error'
                    ] # test function and its parameters

# op deze manier kunnen we tests aan elkaar chainen
# elke test returned dan een result object
# deze results kunnen dan worden herwerkt door een bovenliggende test


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

#echo "\nCoffeeScript: use strict\n"
#git --no-pager grep --break --heading --files-without-match -nP "^'use strict'|\"use strict\"" -- '*.coffee'
#
#echo "\nJade: use unbuffered comments\n"
#git --no-pager grep --break --heading -nP '//\s?(?![-, www])' -- '*.jade'
#
#echo "\nSass: use unbuffered comments\n"
#git --no-pager grep --break --heading -nP '(/\*)|(\*/)' -- '*.sass'
#
#echo "\nSass: don't use hardcoded color codes\n"
#git --no-pager grep --break --heading -nP ': #' -- '*.sass'
#
#echo "\nCoffeeScript: use unbuffered comments\n"
#git --no-pager grep --break --heading -nP '###' -- '*.coffee'
#
#echo "\nCoffeeScript: no console.log\n"
#git --no-pager grep --break --heading -nP 'console\.log' -- '*.coffee'