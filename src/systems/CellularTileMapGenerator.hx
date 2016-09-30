package systems;

import components.TileMap;
import edge.ISystem;
import edge.View;
import edge.Entity;
import haxe.ds.Vector;

class CellularTileMapGenerator implements ISystem {
	var entity:Entity;

	private function clamp(x:Int, a:Int, b:Int):Int {
			return if(x < a) a; else if(x > b) b; else x;
		}

	private function countNeighbouringWalls(map:TileMap, x:Int, y:Int, distance:Int):Int {
		var xStart:Int = clamp(x - distance, 0, map.width - 1);
		var xEnd:Int = clamp(x + distance, 0, map.width - 1);
		var yStart:Int = clamp(y - distance, 0, map.height - 1);
		var yEnd:Int = clamp(y + distance, 0, map.height - 1);

		var count:Int = 0;
		for(j in yStart...(yEnd + 1)) {
			for(i in xStart...(xEnd + 1)) {
				if(map.map[j][i] == TTile.Floor)
					count++;
			}
		}

		return count;
	}

	private function floodFill(map:TileMap, x:Int, y:Int):Int {
		if(map.map[y][x] == TTile.FloodFill) return 0;
		if(map.map[y][x] != TTile.Floor) return 0;

		map.set(x, y, TTile.FloodFill);
		var numChanged:Int = 1;

		if(x > 0) numChanged += floodFill(map, x - 1, y);
		if(x < map.width - 1) numChanged += floodFill(map, x + 1, y);
		if(y > 0) numChanged += floodFill(map, x, y - 1);
		if(y < map.height - 1) numChanged += floodFill(map, x, y + 1);

		return numChanged;
	}

	public function update(generator:components.CellularTileMapGenerator) {
		var oldMap:TileMap = new TileMap(generator.width, generator.height);
		var newMap:TileMap = new TileMap(generator.width, generator.height);

		// seed the old map
		for(y in 0...generator.height)
			for(x in 0...generator.width)
				oldMap.set(x, y,
					Math.random() <= generator.initialWallProbability ? TTile.Floor : TTile.Wall
				);

		if(Std.random(2) == 0) {
			// horizontally blank
			var midY:Int = Std.int(generator.height / 2);
			for(y in (midY-1)...(midY+2))
				for(x in 0...generator.width)
					oldMap.set(x, y, TTile.Floor);
		}
		else {
			// vertically blank
			var midX:Int = Std.int(generator.width / 2);
			for(x in (midX-1)...(midX+2))
				for(y in 0...generator.height)
					oldMap.set(x, y, TTile.Floor);
		}

		// add a border
		for(x in 0...generator.width) {
			oldMap.set(x, 0, TTile.Wall);
			oldMap.set(x, generator.height - 1, TTile.Wall);
		}
		for(y in 0...generator.height) {
			oldMap.set(0, y, TTile.Wall);
			oldMap.set(generator.width - 1, y, TTile.Wall);
		}

		// iteratively generate
		for(i in 0...4) {
			for(y in 1...(generator.height - 1)){
				for(x in 1...(generator.width - 1)) {
					var r1Count:Int = countNeighbouringWalls(oldMap, x, y, 1);
					var r2Count:Int = countNeighbouringWalls(oldMap, x, y, 2);
					newMap.set(x, y, (r1Count >= 5 || r2Count <= 2) ? TTile.Floor : TTile.Wall);
				}
			}
			oldMap = newMap;
			newMap = new TileMap(generator.width, generator.height);
		}
		for(i in 0...3) {
			for(y in 1...(generator.height - 1)){
				for(x in 1...(generator.width - 1)) {
					var r1Count:Int = countNeighbouringWalls(oldMap, x, y, 1);
					newMap.set(x, y, (r1Count >= 5) ? TTile.Floor : TTile.Wall);
				}
			}
			oldMap = newMap;
			newMap = new TileMap(generator.width, generator.height);
		}

		// pick a random spot for flood fill
		var tries:Int = 0;
		var bestTry:Int = 0;
		var bestFloorSize:Int = 0;
		var results:Vector<TileMap> = new Vector<TileMap>(generator.maxTries);
		var floorSize:Int = 0;
		do {
			var ffX:Int;
			var ffY:Int;
			do {
				ffX = Std.random(generator.width);
				ffY = Std.random(generator.height);
			} while(oldMap.map[ffY][ffX] != TTile.Floor);
			// flood fill!
			results[tries] = new TileMap(generator.width, generator.height);
			for(y in 0...generator.height)
				for(x in 0...generator.width)
					results[tries].set(x, y, oldMap.map[y][x]);
			floorSize = floodFill(results[tries], ffX, ffY);

			if(floorSize > bestFloorSize) {
				bestFloorSize = floorSize;
				bestTry = tries;
			}

			tries++;
		} while(tries < generator.maxTries && floorSize / (generator.width * generator.height) < generator.minTargetFloorProbability);

		//trace('generated with ${tries} tries (best = ${bestTry}), getting ${Math.round(100 * bestFloorSize / (generator.width * generator.height))}% coverage');

		// create a new map from the ashes
		var tileMap:TileMap = new TileMap(generator.width, generator.height);
		for(y in 0...generator.height)
			for(x in 0...generator.width)
				tileMap.set(x, y, switch(results[bestTry].map[y][x]) {
					case TTile.FloodFill: TTile.Floor;
					case _: TTile.Wall;
				});

		// swap the generator for the generated
		entity.remove(generator);
		entity.add(tileMap);
	} 
}