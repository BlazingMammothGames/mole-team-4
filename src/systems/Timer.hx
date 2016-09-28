package systems;

import edge.ISystem;
import edge.View;
import edge.Entity;

class Timer implements ISystem {
	var timeDelta:Float;
	var entity:Entity;

	public function update(timer:components.Timer) {
		timer.time -= timeDelta;
		if(timer.time <= 0) {
			if(timer.event != null)
				entity.engine.create([new components.Event(timer.event)]);
			entity.destroy();
		}
	} 
}