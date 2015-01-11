define ['jQuery', 'phaser'], ($, Phaser) ->
	$( ->
		preload = -> game.load.image('logo', 'web/img/phaser.png')
		create = ->
			logo = game.add.sprite(game.world.centerX, game.world.centerY, 'logo')
			logo.anchor.setTo(0.5, 0.5)

		gameOptions =
			preload: preload
			create: create

		game = new Phaser.Game(800, 600, Phaser.AUTO, '', gameOptions);
	)
