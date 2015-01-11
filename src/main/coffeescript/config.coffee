require.config
	deps: ['app']

	baseUrl: 'web/js'

	paths:
		phaser: '/web/bower_components/phaser/build/phaser'
		jQuery: '/web/bower_components/jquery/dist/jquery'

	shim:
		phaser:
			exports: 'Phaser'

		jQuery:
			exports: 'jQuery'
			init: -> @.jQuery.noConflict()
