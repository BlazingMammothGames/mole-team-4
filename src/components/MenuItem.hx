package components;

import edge.IComponent;

class MenuItem implements IComponent {
	public var index:Int;
	public var event:TEvent;

	public function new(index:Int, event:TEvent) {
		this.index = index;
		this.event = event;
	}
}