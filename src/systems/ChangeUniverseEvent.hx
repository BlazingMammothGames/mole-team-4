package systems;

import components.Event;
import edge.Entity;
import edge.ISystem;

class ChangeUniverseEvent implements ISystem {
	var entity:Entity;

	public function update(event:Event) {
		switch(event.event) {
			case TEvent.ChangeUniverse(verse): {
				entity.destroy();
				Main.changeUniverse(verse);
			}
			default: {}
		}
	} 
}