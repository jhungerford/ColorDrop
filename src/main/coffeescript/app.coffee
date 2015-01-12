define ['jQuery', 'phaser'], ($, Phaser) ->
	$( ->
		PLATFORM_SPEED = 150

		NUM_PLATFORMS = 3

		PLAYER_WIDTH = 23
		PLAYER_X_SPEED = 2*PLATFORM_SPEED
		PLAYER_Y_SPEED = 3*PLATFORM_SPEED

		randomBetween = (start, end) -> Math.random() * (end - start) + start

		class Color
			constructor: (@hex, @key, @file) ->

		# http://www.google.com/design/spec/style/color.html
		colors =
			background: new Color(0xCFD8DC, 'background', 'web/img/background.gif') # blue gray 100
			platform: new Color(0x263238, 'platform', 'web/img/platform.gif') # blue gray 900
			red: new Color(0xEF9A9A, 'red', 'web/img/red.gif') # red 200
			yellow: new Color(0xFFF59D, 'yellow', 'web/img/yellow.gif') # yellow 200
			blue: new Color(0x90CAF9, 'blue', 'web/img/blue.gif') # blue 200
			green: new Color(0xA5D6A7, 'green', 'web/img/green.gif') # green 200
			purple: new Color(0xCE93D8, 'purple', 'web/img/purple.gif') # purple 200

		allColors = [
			colors.background, colors.platform, colors.red, colors.yellow, colors.blue, colors.green, colors.purple
		]

		zoneColors = [
			colors.red, colors.yellow, colors.blue, colors.green, colors.purple
		]

		class Row
			constructor: (platforms, y) ->
				@leftSide = @createPlatform(platforms, y)
				@rightSide = @createPlatform(platforms, y)

				@generateGap()

			createPlatform: (platforms, y) ->
				platform = platforms.create(0, y, 'platform')
				platform.height = 20
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
				game.load.image(color.key, color.file) for color in allColors
				true

			create: ->
				game.stage.backgroundColor = colors.background.hex
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
