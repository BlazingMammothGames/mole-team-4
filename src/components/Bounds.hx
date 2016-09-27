package components;

import edge.IComponent;

class Bounds implements IComponent {
	public var minX:Float;
	public var maxX:Float;
	public var minY:Float;
	public var maxY:Float;
	public var minZ:Float;
	public var maxZ:Float;

	public function new() {}

	public function x(?min:Float, ?max:Float):Bounds {
		minX = min;
		maxX = max;
		return this;
	}

	public function y(?min:Float, ?max:Float):Bounds {
		minY = min;
		maxY = max;
		return this;
	}

	public function z(?min:Float, ?max:Float):Bounds {
		minZ = min;
		maxZ = max;
		return this;
	}
}