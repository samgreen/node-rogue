// Generated by CoffeeScript 1.4.0
var Level, TILE_TYPE;

TILE_TYPE = {
  INVALID: 0,
  FLOOR: 1,
  WALL: 2,
  DOOR: 3
};

Level = (function() {

  function Level(sizeX, sizeY) {
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.sizeX = Math.round(this.sizeX);
    this.sizeY = Math.round(this.sizeY);
    this.initMap();
    this.monsters = [];
  }

  Level.prototype.initMap = function() {
    var _this = this;
    console.log("Creating Level " + this.sizeX + "x" + this.sizeY);
    this.map = {};
    this.name = "Troll's Hole";
    this.forTiles(function(tile, x, y) {
      if (x === 0 || x === _this.sizeX - 1 || y === 0 || y === _this.sizeY - 1) {
        return _this.setTile(x, y, TILE_TYPE.WALL);
      } else {
        return _this.setTile(x, y, TILE_TYPE.INVALID);
      }
    });
    this.generateRooms();
    return this.generateTunnels();
  };

  Level.prototype.generateRooms = function() {
    var i, numRooms, _i, _results;
    numRooms = Math.random() * 5 + 5;
    _results = [];
    for (i = _i = 0; 0 <= numRooms ? _i < numRooms : _i > numRooms; i = 0 <= numRooms ? ++_i : --_i) {
      _results.push(this.generateRoom());
    }
    return _results;
  };

  Level.prototype.generateRoom = function() {
    var maxX, maxY, pos, randomDoor, size, x, y, _i, _ref, _results;
    size = this.generateRoomSize();
    pos = this.generateRoomPos(size);
    while (!this.isValidRoom(pos.x, pos.y, size.x, size.y)) {
      size = this.generateRoomSize();
      pos = this.generateRoomPos(size);
    }
    console.log("Creating room at " + pos.x + "x" + pos.y + " with size " + size.x + "x" + size.y);
    maxX = pos.x + size.x;
    maxY = pos.y + size.y;
    _results = [];
    for (y = _i = _ref = pos.y; _ref <= maxY ? _i <= maxY : _i >= maxY; y = _ref <= maxY ? ++_i : --_i) {
      _results.push((function() {
        var _j, _ref1, _results1;
        _results1 = [];
        for (x = _j = _ref1 = pos.x; _ref1 <= maxX ? _j <= maxX : _j >= maxX; x = _ref1 <= maxX ? ++_j : --_j) {
          if (x === pos.x || x === maxX || y === pos.y || y === maxY) {
            randomDoor = Math.random() > 0.95;
            if (randomDoor) {
              _results1.push(this.setTile(x, y, TILE_TYPE.DOOR));
            } else {
              _results1.push(this.setTile(x, y, TILE_TYPE.WALL));
            }
          } else {
            _results1.push(this.setTile(x, y, TILE_TYPE.FLOOR));
          }
        }
        return _results1;
      }).call(this));
    }
    return _results;
  };

  Level.prototype.generateRoomPos = function(size) {
    var pos;
    return pos = {
      x: Math.max(Math.round(Math.random() * (this.sizeX - size.x - 1)), 0),
      y: Math.max(Math.round(Math.random() * (this.sizeY - size.y - 1)), 0)
    };
  };

  Level.prototype.generateRoomSize = function() {
    var size;
    return size = {
      x: Math.round(Math.random() * 5 + 5),
      y: Math.round(Math.random() * 5 + 5)
    };
  };

  Level.prototype.isValidRoom = function(startX, startY, width, height) {
    var maxX, maxY, valid, x, y, _i, _j;
    if (startX < 0 || startY < 0) {
      return false;
    }
    if (width <= 0 || height <= 0) {
      return false;
    }
    maxX = startX + width;
    maxY = startY + height;
    valid = true;
    for (y = _i = startY; startY <= maxY ? _i <= maxY : _i >= maxY; y = startY <= maxY ? ++_i : --_i) {
      for (x = _j = startX; startX <= maxX ? _j <= maxX : _j >= maxX; x = startX <= maxX ? ++_j : --_j) {
        if (!this.isTileInvalid(x, y)) {
          valid = false;
          break;
        }
      }
    }
    return valid;
  };

  Level.prototype.generateTunnels = function() {
    var _this = this;
    return this.forTilesType(TILE_TYPE.DOOR, function(tile, x, y) {
      var neighbors, tileX, tileY, _i, _j, _k, _l, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _results, _results1, _results2, _results3;
      neighbors = _this.getNeighbors(x, y);
      if (neighbors.left === TILE_TYPE.INVALID) {
        _results = [];
        for (tileX = _i = _ref = x - 1; _ref <= 0 ? _i <= 0 : _i >= 0; tileX = _ref <= 0 ? ++_i : --_i) {
          if (_this.isTileInvalid(tileX, y)) {
            _results.push(_this.setTile(tileX, y, TILE_TYPE.FLOOR));
          } else {
            _this.setTile(tileX, y, TILE_TYPE.FLOOR);
            break;
          }
        }
        return _results;
      } else if (neighbors.right === TILE_TYPE.INVALID) {
        _results1 = [];
        for (tileX = _j = _ref1 = x + 1, _ref2 = _this.sizeX; _ref1 <= _ref2 ? _j < _ref2 : _j > _ref2; tileX = _ref1 <= _ref2 ? ++_j : --_j) {
          if (_this.isTileInvalid(tileX, y)) {
            _results1.push(_this.setTile(tileX, y, TILE_TYPE.FLOOR));
          } else {
            _this.setTile(tileX, y, TILE_TYPE.FLOOR);
            break;
          }
        }
        return _results1;
      } else if (neighbors.up === TILE_TYPE.INVALID) {
        _results2 = [];
        for (tileY = _k = _ref3 = y - 1; _ref3 <= 0 ? _k <= 0 : _k >= 0; tileY = _ref3 <= 0 ? ++_k : --_k) {
          if (_this.isTileInvalid(x, tileY)) {
            _results2.push(_this.setTile(x, tileY, TILE_TYPE.FLOOR));
          } else {
            break;
          }
        }
        return _results2;
      } else if (neighbors.down === TILE_TYPE.INVALID) {
        _results3 = [];
        for (tileY = _l = _ref4 = y + 1, _ref5 = _this.sizeY; _ref4 <= _ref5 ? _l < _ref5 : _l > _ref5; tileY = _ref4 <= _ref5 ? ++_l : --_l) {
          if (_this.isTileInvalid(x, tileY)) {
            _results3.push(_this.setTile(x, tileY, TILE_TYPE.FLOOR));
          } else {
            break;
          }
        }
        return _results3;
      }
    });
  };

  Level.prototype.makeTileKey = function(x, y) {
    return "" + x + "," + y;
  };

  Level.prototype.setTile = function(x, y, tile) {
    var key;
    key = this.makeTileKey(x, y);
    return this.map[key] = tile;
  };

  Level.prototype.tileAt = function(x, y) {
    var key;
    key = this.makeTileKey(x, y);
    return this.map[key];
  };

  Level.prototype.isTileFloor = function(x, y) {
    return this.tileAt(x, y) === TILE_TYPE.FLOOR;
  };

  Level.prototype.isTileInvalid = function(x, y) {
    return this.tileAt(x, y) === TILE_TYPE.INVALID;
  };

  Level.prototype.isTileWall = function(x, y) {
    return this.tileAt(x, y) === TILE_TYPE.WALL;
  };

  Level.prototype.isTileDoor = function(x, y) {
    return this.tileAt(x, y) === TILE_TYPE.DOOR;
  };

  Level.prototype.isTileInRoom = function(x, y) {
    return this.isTileFloor(x, y || this.isTileWall(x, y));
  };

  Level.prototype.getNeighbors = function(x, y) {
    var neighbors;
    return neighbors = {
      left: this.tileAt(x - 1, y),
      up: this.tileAt(x, y - 1),
      right: this.tileAt(x + 1, y),
      down: this.tileAt(x, y - 1)
    };
  };

  Level.prototype.getRandomSpawnPos = function() {
    var tile, _results;
    tile = this.getRandomTile();
    _results = [];
    while (tile !== TILE_TYPE.FLOOR) {
      _results.push(tile = this.getRandomTile());
    }
    return _results;
  };

  Level.prototype.getRandomTile = function() {
    var randomKey, tile;
    tile = {
      x: Math.round(Math.random() * this.sizeX),
      y: Math.round(Math.random() * this.sizeY)
    };
    randomKey = this.makeTileKey(tile.x, tile.y);
    return this.map[randomKey];
  };

  Level.prototype.addHero = function(hero) {
    this.hero = hero;
    if (!this.hero) {
      return console.log("Hero added: " + (this.hero.toString()));
    } else {
      return console.log("Hero already added! Details: " + (this.hero.toString()));
    }
  };

  Level.prototype.addMonster = function(monster) {
    return monsters.push(monster);
  };

  Level.prototype.forTiles = function(iterator) {
    var tile, x, y, _i, _ref, _results;
    _results = [];
    for (y = _i = 0, _ref = this.sizeY; 0 <= _ref ? _i < _ref : _i > _ref; y = 0 <= _ref ? ++_i : --_i) {
      _results.push((function() {
        var _j, _ref1, _results1;
        _results1 = [];
        for (x = _j = 0, _ref1 = this.sizeX; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; x = 0 <= _ref1 ? ++_j : --_j) {
          tile = this.tileAt(x, y);
          _results1.push(iterator(tile, x, y));
        }
        return _results1;
      }).call(this));
    }
    return _results;
  };

  Level.prototype.forTilesType = function(tileType, iterator) {
    return this.forTiles(function(tile, x, y) {
      if (tile === tileType) {
        return iterator(tile, x, y);
      }
    });
  };

  Level.prototype.toString = function() {
    var description, row, x, y, _i, _j, _ref, _ref1;
    description = '';
    for (y = _i = 0, _ref = this.sizeY; 0 <= _ref ? _i < _ref : _i > _ref; y = 0 <= _ref ? ++_i : --_i) {
      row = '';
      for (x = _j = 0, _ref1 = this.sizeX; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; x = 0 <= _ref1 ? ++_j : --_j) {
        row += this.tileAt(x, y);
      }
      description += row + '\n';
    }
    return description;
  };

  return Level;

})();

module.exports = Level;