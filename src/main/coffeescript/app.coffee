define ['jQuery', 'phaser'], ($, Phaser) ->
	$( ->
		player = null
		platforms = null
		cursors = null

		PLATFORM_SPEED = 150

		PLAYER_WIDTH = 23
		PLAYER_X_SPEED = PLATFORM_SPEED
		PLAYER_Y_SPEED = 3*PLATFORM_SPEED

		randomBetween = (start, end) -> Math.random() * (end - start) + start

		class Row
			constructor: ->
				@gapWidth = randomBetween(PLAYER_WIDTH, PLAYER_WIDTH * 5)
				@gapStart = randomBetween(PLAYER_WIDTH, game.world.width - @gapWidth - PLAYER_WIDTH)

			create: (platforms) ->
				leftSide = platforms.create(0, game.world.height, 'platform')
				leftSide.width = @gapStart
				leftSide.body.immovable = true
				leftSide.body.velocity.y = -1 * PLATFORM_SPEED;

				rightSide = platforms.create(@gapStart + @gapWidth, game.world.height, 'platform')
				rightSide.width = game.world.width - @gapStart - @gapWidth
				rightSide.body.immovable = true
				rightSide.body.velocity.y = -1 * PLATFORM_SPEED

		class Player
			constructor: ->
				@sprite = game.add.sprite(game.world.centerX, game.world.centerY, 'player_gray')
				game.physics.arcade.enable(@sprite)

				@sprite.body.bounce.y = 0.2
				@sprite.body.gravity.y = PLAYER_Y_SPEED
				@sprite.body.collideWorldBounds = true

			handleInput: ->
				@sprite.body.velocity.x = 0
				if cursors.left.isDown
					@sprite.body.velocity.x = -1 * PLAYER_X_SPEED
				else if cursors.right.isDown
					@sprite.body.velocity.x = PLAYER_X_SPEED

		state =
			preload: ->
				game.load.image('player_gray', 'web/img/player_gray.png')
				game.load.image('platform', 'web/img/platform.png')

			create: ->
				game.stage.backgroundColor = 0xFFF0A5
				game.physics.startSystem(Phaser.Physics.ARCADE)

				player = new Player()

				platforms = game.add.group()
				platforms.enableBody = true

				ground = new Row()
				ground.create(platforms)

				cursors = game.input.keyboard.createCursorKeys()

			update: ->
				game.physics.arcade.collide(player.sprite, platforms)

				player.handleInput()

			# Render

		game = new Phaser.Game(800, 600, Phaser.AUTO, '', state);
	)
