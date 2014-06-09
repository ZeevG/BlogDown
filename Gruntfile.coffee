module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    
    # Check Coffee
    coffeelint:
      app: ['src/**/*.coffee']
      options:
        'no_trailing_whitespace':
          level: 'warn'
        'max_line_length':
          level: 'warn'
        'no_unnecessary_fat_arrows':
          level: 'error'
        'no_tabs':
          level: 'warn'
        'indentation':
          level: 'warn'
        'camel_case_classes':
          level: 'warn'

    # Browserify JS
    browserify:
      app:        
        files:
          'dist/js/app.js': ['src/js/app.coffee']
          
    # Copy assets
    copy:
      dist:
        files:
          [
            {expand: true, cwd: 'src/fonts/', src: ['**'], dest: 'dist/fonts/', filter: 'isFile'}
            {expand: true, cwd: 'src/templates/', src: ['*.handlebars'], dest: 'dist/templates/', filter: 'isFile'}
            {expand: true, cwd: 'src/images/', src: ['**'], dest: 'dist/images/'}
            {expand: true, cwd: 'src/css/', src: ['*.css'], dest: 'dist/css/', filter: 'isFile'}
            {expand: true, cwd: 'src/js/vendor/', src: ['*.js'], dest: 'dist/js/vendor/', filter: 'isFile'}
          ]

    # Minify HTML
    htmlmin:
      dist:
        options:
          removeComments: true,
          collapseWhitespace: true,
          removeEmptyAttributes: true,
          removeCommentsFromCDATA: true,
          removeRedundantAttributes: true,
          collapseBooleanAttributes: true 
        files:
          'dist/index.html': 'src/index.html'

    compass:
      dist:
        options:
          sassDir: "src/css"
          cssDir: "dist/css"
          raw: 'preferred_syntax = :sass\n'
          "images-dir": "src/images"
        debugsass: true
      release:
        options:
          sassDir: "src/css"
          cssDir: "release/css"
          raw: 'preferred_syntax = :sass\n'
          "images-dir": "src/images"
        debugsass: false

    # Clean directories
    clean:
      build: ["dist"]
    
    # Server
    connect:
      server:
        options:
          hostname: '0.0.0.0'
          port: 3000,
          base: 'dist/'

    # Watch
    watch:
      livereload:
        files: ["dist/**/*", "dist/*"]
        options:
          livereload: true
      js:
        files: ["Gruntfile.coffee", "src/**/*.coffee", "src/**/*.js"]
        tasks: ["coffeelint", "copy:dist", "browserify"]
      html:
        files: ["src/*.html"]
        tasks: ["htmlmin"]
      css:
        files: ["src/css/*"]
        tasks: ["compass:dist", "copy:dist"]

  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-htmlmin"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-browserify"


  grunt.registerTask "dev", ["coffeelint", "clean:build", "browserify:app", "compass:dist", "copy", "htmlmin:dist", "connect", "watch"]
  grunt.registerTask "default", ["dev"]
