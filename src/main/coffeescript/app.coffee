define ['jQuery', 'phaser'], ($, Phaser) ->
	$( ->
		player = null
		platforms = null
		cursors = null

		state =
			preload: ->
				game.load.image('player_gray', 'web/img/player_gray.png')
				game.load.image('platform', 'web/img/platform.png')

			create: ->
				game.stage.backgroundColor = 0xFFF0A5
				game.physics.startSystem(Phaser.Physics.ARCADE)

				player = game.add.sprite(game.world.centerX, game.world.centerY, 'player_gray')
				game.physics.arcade.enable(player)

				player.body.bounce.y = 0.2
				player.body.gravity.y = 300
				player.body.collideWorldBounds = true

				platforms = game.add.group()
				platforms.enableBody = true

				ground = platforms.create(0, game.world.height - 20, 'platform')
				ground.width = game.world.width
				ground.body.immovable = true

				ground.body.velocity.y = -150

				cursors = game.input.keyboard.createCursorKeys()

			update: ->
				game.physics.arcade.collide(player, platforms)

				player.body.velocity.x = 0

				if cursors.left.isDown
					player.body.velocity.x = -150
				else if cursors.right.isDown
					player.body.velocity.x = 150

			# Render

		game = new Phaser.Game(800, 600, Phaser.AUTO, '', state);
	)
