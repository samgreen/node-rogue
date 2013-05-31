class Generator
	constructor: (@sizeX, @sizeY) ->
		@initMap()

	initMap: ->
		console.log "Creating Level #{@sizeX}x#{@sizeY}"

		@map = {}
		@forTiles (tile, x, y) =>
			# Enclose the edges of the dungeon
			if x == 0 or x == @sizeX - 1 or y == 0 or y == @sizeY - 1
				@setTile x, y, TILE_TYPE.WALL
			else
				@setTile x, y, TILE_TYPE.INVALID

		# Generate all rooms
		@generateRooms()

		# Generate tunnels
		@generateTunnels()
		
	generate: ->


module.exports = Generator