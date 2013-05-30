Unit = require './unit'

class Monster extends Unit
	constructor: (hp, name, pos) ->
		@super hp, name, pos

module.exports = Monster