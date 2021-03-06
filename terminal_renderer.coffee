Charm = require 'charm'

TILE_TYPE =
	INVALID:	0
	FLOOR:		1
	WALL:		2
	DOOR:		3

TILE_CHAR = [
	' '
	'.'
	'#'
	'D'
]

TILE_FG_COLORS = [
	238
	'green'
	8
	'blue'
]

TILE_BG_COLORS = [
	240
	'cyan'
	7
	'yellow'
]

TILE_ATTR = [
	'reset'
	'dim'
	'bright'
	'reset'
]

class TerminalRenderer
	constructor: (@game) ->
		@level = @game.level

		@charm = new Charm()
		@charm.pipe process.stdout
		@charm.reset()
		@charm.cursor true

		# stdin = process.openStdin()
		# require('tty').setRawMode true 
		# stdin.on 'data', (key) ->
		# 	console.log key.charCodeAt(0)
		# 	# Kill the process with Control + Z
		# 	if key == '\u0003' then process.exit()

	clear: ->
		@charm.erase 'screen'

	draw: ->
		@drawLevel()
		@drawHero()
		@drawStats()

	drawLevel: ->
		# Save the current state
		@charm.push true

		# Iterate over the whole level
		@level.forTiles (tile, x, y) =>
			@drawTile tile, x, y

		# Restore the state
		@charm.pop true

	drawTile: (tileType, x, y, foreColor, backColor) ->
		tile = TILE_CHAR[tileType]

		bgColor = TILE_BG_COLORS[tileType] unless backColor
		fgColor = TILE_FG_COLORS[tileType] unless foreColor

		# Set the attribute
		@charm.display TILE_ATTR[tileType]

		# Draw the char
		@drawChar tile, x, y, fgColor, bgColor

	drawChar: (char, x, y, fgColor, bgColor) ->
		# Move the cursor
		@charm.position x + 1, y + 1

		if fgColor
			# Set the colors
			@charm.foreground fgColor

		if bgColor
			@charm.background bgColor

		# Write the character
		@charm.write char		

	drawHero: ->
		hero = @game.hero
		@drawChar '@', hero.pos.x, hero.pos.y, 'red'

	drawMonsters: ->

	drawStats: ->
		# Save the current state
		# @charm.push false

		@charm.position 0, @level.sizeY + 1
		@charm.write "Dungeon Master III"

		locationString = "Location: #{@level.name}"
		@charm.position @level.sizeX - locationString.length, @level.sizeY + 1

		@charm.foreground 'white'
		@charm.write "Location: "
		# Move 1 space right
		@charm.move 1

		@charm.foreground 'yellow'
		@charm.write @level.name

		# Restore the state
		# @charm.pop false


module.exports = TerminalRenderer
		