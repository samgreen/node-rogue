Unit = require './unit'

class Hero extends Unit
	constructor: (hp, name, pos) ->
		super hp, name, pos

module.exports = Hero