package components;

import edge.IComponent;

class ScrollImage implements IComponent {
	public var speedY:Float;
	public var minY:Int;
	public var maxY:Int;

	public var dY:Float = 0;
	public var done:Bool = false;

	public function new(speedY:Float, minY:Int, maxY:Int) {
		this.speedY = speedY;
		this.minY = minY;
		this.maxY = maxY;
	}
}