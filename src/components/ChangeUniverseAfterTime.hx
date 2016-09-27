package components;

import edge.IComponent;

class ChangeUniverseAfterTime implements IComponent {
	public var universe:String;
	public var time:Float;

	public function new(universe:String, time:Float) {
		this.universe = universe;
		this.time = time;
	}
}