package components;

import edge.IComponent;

class Position implements IComponent {
	public var x:Float;
	public var y:Float;
	public var z:Float;

	public function new(x:Float, y:Float, z:Float=0) {
		this.x = x;
		this.y = y;
		this.z = z;
	}
}