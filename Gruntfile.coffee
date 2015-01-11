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

		bowerRequirejs:
			target:
				rjsConfig: 'target/classes/web/js/app.js'

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-bower-requirejs'

	grunt.registerTask 'default', ['bowerRequirejs', 'coffee']
