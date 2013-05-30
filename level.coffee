TILE_TYPE =
	INVALID:	0
	FLOOR:		1
	WALL:		2
	DOOR:		3

class Level
	constructor: (@sizeX, @sizeY) ->
		@sizeX = Math.round @sizeX
		@sizeY = Math.round @sizeY
		# Initialize the map and all rooms
		@initMap()
		
		@monsters = []

	initMap: ->
		console.log "Creating Level #{@sizeX}x#{@sizeY}"

		@map = {}
		for y in [0...@sizeY]
			for x in [0...@sizeX]
				# Enclose the edges of the dungeon
				if x == 0 or x == @sizeX - 1 or y == 0 or y == @sizeY - 1
					@setTile x, y, TILE_TYPE.WALL
				else
					@setTile x, y, TILE_TYPE.INVALID

		# Generate all rooms
		@generateRooms()

	generateRooms: ->
		numRooms = Math.random() * 5 + 5
		for i in [0...numRooms]
			@generateRoom()

	generateRoom: ->
		size = @generateRoomSize()
		pos = @generateRoomPos(size)
			
		until @isValidRoom pos.x, pos.y, size.x, size.y
			size = @generateRoomSize()
			pos = @generateRoomPos(size)


		console.log "Creating room at #{pos.x}x#{pos.y} with size #{size.x}x#{size.y}"

		maxX = pos.x + size.x
		maxY = pos.y + size.y
		for y in [pos.y..maxY]
			for x in [pos.x..maxX]
				if x == pos.x or x == maxX or y == pos.y or y == maxY
					randomDoor = Math.random() > 0.95
					if randomDoor
						@setTile x, y, TILE_TYPE.DOOR
					else
						@setTile x, y, TILE_TYPE.WALL
				else
					@setTile x, y, TILE_TYPE.FLOOR

	generateRoomPos: (size) ->
		pos =
			x: Math.max(Math.round(Math.random() * (@sizeX - size.x - 1)), 0)
			y: Math.max(Math.round(Math.random() * (@sizeY - size.y - 1)), 0)

	generateRoomSize: ->
		size =
			x: Math.round(Math.random() * 5 + 5)
			y: Math.round(Math.random() * 5 + 5)
		
	isValidRoom: (startX, startY, width, height) ->
		# console.log "Checking room validity at #{startX}x#{startY} with size #{width}x#{height}"

		if startX < 0 or startY < 0 then return false
		if width <= 0 or height <= 0 then return false

		maxX = startX + width
		maxY = startY + height

		valid = true

		for y in [startY..maxY]
			for x in [startX..maxX]
				unless @isTileInvalid x, y
					valid = false
					break

		# console.log "Room is valid? #{valid}"

		return valid

	generateTunnels: ->

	makeTileKey: (x, y) ->
		return "#{x},#{y}"

	setTile: (x, y, tile) ->
		key = @makeTileKey x, y
		@map[key] = tile	

	tileAt: (x, y) ->
		key = @makeTileKey x, y
		return @map[key]

	isTileFloor: (x, y) ->
		return @tileAt(x, y) == TILE_TYPE.FLOOR

	isTileInvalid: (x, y) ->
		return @tileAt(x, y) == TILE_TYPE.INVALID

	isTileWall: (x, y) ->
		return @tileAt(x, y) == TILE_TYPE.WALL

	isTileDoor: (x, y) ->
		return @tileAt(x, y) == TILE_TYPE.DOOR

	isTileInRoom: (x, y) ->
		return @isTileFloor x, y or @isTileWall x, y

	getRandomSpawnPos: ->
		tile = @getRandomTile()
		while tile != TILE_TYPE.FLOOR
			tile = @getRandomTile()

	getRandomTile: ->
		tile = 
			x: Math.round Math.random() * @sizeX
			y: Math.round Math.random() * @sizeY
		randomKey = @makeTileKey tile.x, tile.y
		return @map[randomKey]

	addHero: (@hero) ->
		unless @hero
			console.log "Hero added: #{@hero.toString()}"
		else
			console.log "Hero already added! Details: #{@hero.toString()}"

	addMonster: (monster) ->
		monsters.push monster

	toString: ->
		description = ''
		for y in [0...@sizeY]
			row = ''
			for x in [0...@sizeX]
				row += @tileAt x, y

			# Add this row to our description
			description += row + '\n'

		# Return the string description of our map
		return description

module.exports = Level
