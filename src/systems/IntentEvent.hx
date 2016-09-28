package systems;

import edge.ISystem;
import edge.View;
import edge.Entity;

class IntentEvent implements ISystem {
	var entity:Entity;

	public function update(intentEvent:components.IntentEvent) {
		if(Main.intended(intentEvent.intent))
			entity.engine.create([new components.Event(intentEvent.event)]);
	} 
}