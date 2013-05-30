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
	constructor: (@level) ->
		@charm = new Charm()
		@charm.pipe process.stdout
		@charm.reset()

	clear: ->
		@charm.erase 'screen'

	draw: ->
		@drawLevel()
		@drawStats()

	drawLevel: ->
		# Save the current state
		@charm.push true

		# Iterate over the whole level
		for x in [0...@level.sizeX]
			for y in [0...@level.sizeY]
				tile = @level.tileAt x, y
				@drawTile tile, x, y, 'red'

		# Restore the state
		@charm.pop true

	drawTile: (tileType, x, y, color) ->
		# Move the cursor
		@charm.position x + 1, y + 1
		# Get the character representing this type
		tile = TILE_CHAR[tileType]
		# Set the colors
		@charm.foreground TILE_FG_COLORS[tileType]
		@charm.background TILE_BG_COLORS[tileType]
		# Set the attribute
		@charm.display TILE_ATTR[tileType]
		# Write the character
		@charm.write tile

	drawStats: ->
		# Save the current state
		# @charm.push true

		@charm.position 0, @level.sizeY + 1
		@charm.write 'Test'

		# Restore the state
		# @charm.pop true


module.exports = TerminalRenderer
		