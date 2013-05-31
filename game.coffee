Level = require './level'
Hero = require './units/hero'

DEBUG = true

class Game
	constructor: ->
		@setupLevel()
		@addHero()

	setupLevel: ->
		# Generate random sizes 40x10 to 80x20
		# sizeX = Math.random() * 40 + 40
		# sizeY = Math.random() * 10 + 10

		@level = new Level 100, 25

		if DEBUG
			console.log @level.toString()

	addHero: ->
		heroPos = @level.getRandomSpawnPos()
		@hero = new Hero 15, "Hero", { x: 15, y: 20 }
		@level.addHero @hero

module.exports = Game

if DEBUG
	game = new Game()
