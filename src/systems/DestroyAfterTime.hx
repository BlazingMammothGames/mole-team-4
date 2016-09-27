package systems;

import edge.Entity;
import edge.ISystem;

class DestroyAfterTime implements ISystem {
	var entity:Entity;
	var timeDelta:Float;

	public function update(destroy:components.DestroyAfterTime) {
		destroy.time -= timeDelta;
		if(destroy.time <= 0) {
			entity.destroy();
		}
	} 
}