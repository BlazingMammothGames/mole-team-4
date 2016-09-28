package components;

import edge.IComponent;

class Event implements IComponent {
	public var event:TEvent;

	public function new(event:TEvent) {
		this.event = event;
	}
}