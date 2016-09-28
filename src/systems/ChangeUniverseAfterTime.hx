package systems;

import edge.Entity;
import edge.ISystem;

class ChangeUniverseAfterTime implements ISystem {
	var timeDelta:Float;
	public function update(change:components.ChangeUniverseAfterTime) {
		change.time -= timeDelta;
		if(change.time <= 0) {
			Main.changeUniverse(change.universe);
		}
	} 
}