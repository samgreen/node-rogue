Monster = require './monster'

class Rat extends Monster
	constructor: (pos) ->
		@super 5, "Rat", pos

	randomAttackDamage: ->
		# Rats attack for 1 - 5 health
		return Math.round(Math.max(Math.random() * 5, 1))

module.exports = Rat