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
                # Possible values: 'included' | 'excluded'
              line: 1
                # Unstable, not sure if this will stay in
                # Optional
                # Possible values: 1 | 2 | ...
                # TODO: <improvement> support ranges
              justifiable: 'no'
                # Optional, defaults to 'yes'
                # Possible values: 'no' | 'yes' | 'warning' | ...
              description: 'No IDs should be used in Sass files'
                # Optional
                # The description of the test, this will be used as output in the console and the reporter
              chainCondition: true
                # Optional, defaults to true, only used when chain is defined
                # Possible values: true | false
                # If this condition is true/false, run the chained test
              chain:
                # Optional
                # This will chain another test if the condition of the parent has been met
                noIdOtherPredefinedTest:
                  test: 'noUnbufferedComments'
                    # Optional, if not defined, the 'pattern' parameter is required
                    # Possible values: another test name
                  condition: 'excluded'
                  occur: 'before'
                    # Optional, defaults to after
                    # Possible values: 'before' | 'after' | 'sameLine'
                  occurLines: '1'
                    # to  'x' # optional extra for the condition, if not specified, any number is good
                  file: 'otherFile.jade'
                    # Optional, defaults to the same file
                    # Runs this test on (an)other file(s)

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