package components;

import edge.IComponent;
import haxe.ds.Vector;

class TileMap implements IComponent {
	public var width:Int;
	public var height:Int;
	public var map:Vector<Vector<TTile>>;

	public function new(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		map = new Vector<Vector<TTile>>(height);
		for(y in 0...height) {
			map[y] = new Vector<TTile>(width);
			for(x in 0...width)
				map[y][x] = TTile.Wall;
		}
	}

	public function set(x:Int, y:Int, tile:TTile):TileMap {
		map[y][x] = tile;
		return this;
	}
}