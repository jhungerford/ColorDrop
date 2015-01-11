module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON('package.json')

		coffee:
			glob_to_multiple:
				expand: true
				flatten: false
				cwd: 'src/main/coffeescript'
				src: ['*.coffee']
				dest: 'target/classes/web/js/'
				ext: '.js'

#		bower:
#			target:
#				rjsConfig: ''

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-bower-requirejs'

	grunt.registerTask 'default', ['bower', 'coffee']
