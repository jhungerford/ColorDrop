define ['jQuery', 'phaser'], ($, Phaser) ->
	$( ->
		PLATFORM_SPEED = 150

		NUM_PLATFORMS = 3

		PLAYER_WIDTH = 23
		PLAYER_X_SPEED = PLATFORM_SPEED
		PLAYER_Y_SPEED = 3*PLATFORM_SPEED

		randomBetween = (start, end) -> Math.random() * (end - start) + start

		# http://www.google.com/design/spec/style/color.html
		colors =
			background: 0xCFD8DC # blue gray 100
			red: 0xEF9A9A # red 200
			yellow: 0xFFF59D # yellow 200
			blue: 0x90CAF9 # blue 200
			green: 0xA5D6A7 # green 200
			purple: 0xCE93D8 # purple 200



		class Row
			constructor: (platforms, y) ->
				@leftSide = @createPlatform(platforms, y)
				@rightSide = @createPlatform(platforms, y)

				@generateGap()

			createPlatform: (platforms, y) ->
				platform = platforms.create(0, y, 'platform')
				platform.body.immovable = true
				platform.body.velocity.y = -1 * PLATFORM_SPEED
				platform

			generateGap: ->
				gapWidth = randomBetween(PLAYER_WIDTH * 2, PLAYER_WIDTH * 6)
				gapStart = randomBetween(PLAYER_WIDTH, game.world.width - gapWidth - PLAYER_WIDTH)

				@leftSide.width = gapStart
				@rightSide.x = gapStart + gapWidth
				@rightSide.width = game.world.width - gapStart - gapWidth

			wrap: ->
				if (@leftSide.body.y < -1 * PLAYER_WIDTH)
					@generateGap()
					@leftSide.y = game.world.height
					@rightSide.y = game.world.height

		class Player
			constructor: ->
				@sprite = game.add.sprite(game.world.centerX, game.world.centerY, 'player_gray')
				game.physics.arcade.enable(@sprite)

				@sprite.body.bounce.y = 0.2
				@sprite.body.gravity.y = PLAYER_Y_SPEED
				@sprite.body.collideWorldBounds = true

			handleInput: (cursors) ->
				@sprite.body.velocity.x = 0
				if cursors.left.isDown
					@sprite.body.velocity.x = -1 * PLAYER_X_SPEED
				else if cursors.right.isDown
					@sprite.body.velocity.x = PLAYER_X_SPEED

		class State
			preload: ->
				game.load.image('player_gray', 'web/img/player_gray.png')
				game.load.image('platform', 'web/img/platform.png')
				true

			create: ->
				game.stage.backgroundColor = colors.background
				game.physics.startSystem(Phaser.Physics.ARCADE)

				@player = new Player()

				@platforms = game.add.group()
				@platforms.enableBody = true

				@rows = for num in [1..NUM_PLATFORMS]
					new Row(@platforms, (game.world.height / NUM_PLATFORMS) * num)

				@cursors = game.input.keyboard.createCursorKeys()
				true

			update: ->
				game.physics.arcade.collide(@player.sprite, @platforms)

				@player.handleInput(@cursors)

				row.wrap() for row in @rows

				true

			# Render

		game = new Phaser.Game(800, 600, Phaser.AUTO, '', new State());
	)
