define ['jQuery', 'phaser'], ($, Phaser) ->
	$( ->
		player = null
		cursors = null

		state =
			preload: ->
				game.load.image('player_gray', 'web/img/player_gray.png')

			create: ->
				game.stage.backgroundColor = 0xFFF0A5

				game.physics.startSystem(Phaser.Physics.ARCADE)

				player = game.add.sprite(game.world.centerX, game.world.centerY, 'player_gray')

				game.physics.arcade.enable(player)

				cursors = game.input.keyboard.createCursorKeys()

			update: ->
				player.body.velocity.x = 0

				if cursors.left.isDown
					player.body.velocity.x = -150
				else if cursors.right.isDown
					player.body.velocity.x = 150

			# Render

		game = new Phaser.Game(800, 600, Phaser.AUTO, '', state);
	)
