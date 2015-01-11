define ['jQuery', 'phaser'], ($, Phaser) ->
	$( ->
		gameOptions =
			preload: ->
				game.load.spritesheet('sprites', 'web/img/sprite_sheet.png', 100, 100)

			create: ->
				game.stage.backgroundColor = 0xFFF0A5

				players = game.add.graphics(game.world.centerX, game.world.centerY)
				players.lineStyle(3, 0x666666)
				players.beginFill(0xCCCCCC)
				players.drawCircle(0, 0, 20)
				players.endFill()


		game = new Phaser.Game(800, 600, Phaser.AUTO, '', gameOptions);
	)
