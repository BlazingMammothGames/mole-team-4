package components;

import edge.IComponent;

class DestroyAfterTime implements IComponent {
	public var time:Float;

	public function new(time:Float) {
		this.time = time;
	}
}