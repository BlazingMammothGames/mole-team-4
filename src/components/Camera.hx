package components;

import edge.IComponent;
import haxe.ds.Vector;

class Camera implements IComponent {
	public var viewportX:Int;
	public var viewportY:Int;
	public var width:Int;
	public var height:Int;

	public function new(x:Int, y:Int, width:Int, height:Int) {
		this.viewportX = x;
		this.viewportY = y;
		this.width = width;
		this.height = height;
	}
}