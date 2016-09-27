package components;

import edge.IComponent;

class Velocity implements IComponent {
	public var vx:Float;
	public var vy:Float;
	public var vz:Float;

	public function new(vx:Float, vy:Float, vz:Float=0) {
		this.vx = vx;
		this.vy = vy;
		this.vz = vz;
	}
}