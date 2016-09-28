package components;

import edge.IComponent;

class Timer implements IComponent {
	public var time:Float;
	public var event:TEvent;

	public function new(time:Float, event:TEvent) {
		this.time = time;
		this.event = event;
	}
}