// Generated by CoffeeScript 1.4.0
var DEBUG, Game, Hero, Level, game;

Level = require('./level');

Hero = require('./units/hero');

DEBUG = true;

Game = (function() {

  function Game() {
    this.setupLevel();
    this.addHero();
  }

  Game.prototype.setupLevel = function() {
    var sizeX, sizeY;
    sizeX = Math.random() * 40 + 40;
    sizeY = Math.random() * 10 + 10;
    this.level = new Level(sizeX, sizeY);
    if (DEBUG) {
      return console.log(this.level.toString());
    }
  };

  Game.prototype.addHero = function() {
    var hero, heroPos;
    heroPos = this.level.getRandomSpawnPos();
    hero = new Hero(15, "Hero", heroPos);
    return this.level.addHero(this.hero);
  };

  return Game;

})();

module.exports = Game;

if (DEBUG) {
  game = new Game();
}