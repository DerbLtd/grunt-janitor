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
            noId: # This defines the name of the test
              pattern: '#'
                # Mandatory
                # Can be a string or a regex
              severity: 'critical'
                # Optional, defaults to none
                # Possible values: 'critical' | 'error' | 'warning' | 'recommendation' | 'info' | 'none'
              condition: 'excluded'
                # Optional, defaults to excluded
                # Possible values:| 'included' | 'excluded'
              justifiable: 'no'
                # Optional, defaults to 'yes'
                # Possible values: 'no' | 'yes' | 'warning' | '...'
              description: 'No IDs should be used in Sass files'
                # Optional

              chain:
                # Optional
                noIdOtherPredefinedTest:
                  test: 'noUnbufferedComments'
                    # Optional, if not defined, the 'pattern' parameter is required
                    # Possible values: another test name
                  condition: 'excluded'
                  occurs: 'before'
                    # Optional, defaults to after
                    # Possible values: 'before' | 'after' | 'sameLine' # defaults to after
                  lines: '1'
                    # to  'x' # optional extra for the condition, if not specified, any number is good
                  file: 'otherFile.jade'
                    # Optional
                    # Runs this test on another file, defaults to the same file

                noIdNoSomethingElse:
                  pattern: 'derb'
                    # Optional, if not defined, the 'test' parameter is required
                  chain:
                    oneMoreTest:
                      test: 'justOneMore'
                      # And so it can go on and on

            noUnbufferedComments:
              pattern: /(\/\\*)|(\\*\/)/i
              severity: 'warning'
              condition: 'excluded'

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