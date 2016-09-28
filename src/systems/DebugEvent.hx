package systems;

import components.Event;
import edge.Entity;
import edge.ISystem;

class DebugEvent implements ISystem {
	var entity:Entity;

	public function update(event:Event) {
		switch(event.event) {
			case Events.DebugMessage(message): {
				Main.console.debug("Debug:", message);
				entity.destroy();
			}
			default: {}
		}
	} 
}