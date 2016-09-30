package components;

import edge.IComponent;
import haxe.ds.Vector;

class BSPTileMapGenerator implements IComponent {
	public var width:Int;
	public var height:Int;

	public function new(width:Int, height:Int) {
		this.width = width;
		this.height = height;
	}
}