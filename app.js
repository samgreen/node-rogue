var Game = require('./Game');
var TerminalRenderer = require('./terminal_renderer');

var newGame = new Game();

var renderer = new TerminalRenderer(newGame);
renderer.draw();