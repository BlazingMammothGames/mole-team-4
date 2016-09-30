package systems;

import components.TileMap;
import components.TileMapGeneration;
import edge.ISystem;
import edge.View;
import edge.Entity;

class TileMapGenerator implements ISystem {
	var entity:Entity;

	public function update(generator:TileMapGeneration) {
		var tileMap:TileMap = new TileMap(generator.width, generator.height);

		// TODO: generation
		for(y in 0...generator.height) {
			for(x in 0...generator.width) {
				tileMap.set(x, y, switch(Std.random(3)) {
					case 0: TTile.Floor;
					case 1: TTile.Wall;
					case 2: TTile.Door;
					default: null;
				});
			}
		}

		// swap the generator for the generated
		entity.remove(generator);
		entity.add(tileMap);
	} 
}