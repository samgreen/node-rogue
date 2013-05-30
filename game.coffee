Level = require './level'
Hero = require './units/hero'

DEBUG = true

class Game
	constructor: ->
		@setupLevel()
		@addHero()

	setupLevel: ->
		# Generate random sizes 40x10 to 80x20
		sizeX = Math.random() * 40 + 40
		sizeY = Math.random() * 10 + 10

		@level = new Level sizeX, sizeY

		if DEBUG
			console.log @level.toString()

	addHero: ->
		heroPos = @level.getRandomSpawnPos()
		hero = new Hero 15, "Hero", heroPos
		@level.addHero @hero

module.exports = Game

if DEBUG
	game = new Game()
