package components;

import edge.IComponent;
import haxe.ds.Vector;

class CellularTileMapGenerator implements IComponent {
	public var width:Int;
	public var height:Int;
	public var initialWallProbability:Float;

	public function new(width:Int, height:Int, initialWallProbability:Float) {
		this.width = width;
		this.height = height;
		this.initialWallProbability = initialWallProbability;
	}
}