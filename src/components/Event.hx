package components;

import edge.IComponent;

class Event implements IComponent {
	public var event:Events;

	public function new(event:Events) {
		this.event = event;
	}
}