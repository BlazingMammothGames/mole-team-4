package components;

import edge.IComponent;

class IntentEvent implements IComponent {
	public var intent:Intent;
	public var event:TEvent;

	public function new(intent:Intent, event:TEvent) {
		this.intent = intent;
		this.event = event;
	}
}