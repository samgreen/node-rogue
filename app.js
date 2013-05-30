var Level = require('./level');

var firstLevel = new Level(80, 25);

var TerminalRenderer = require('./terminal_renderer');
var renderer = new TerminalRenderer(firstLevel);
renderer.draw();