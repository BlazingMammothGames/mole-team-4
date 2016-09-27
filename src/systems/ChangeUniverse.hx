package systems;

import components.ChangeUniverseAfterTime;
import edge.Entity;
import edge.ISystem;

class ChangeUniverse implements ISystem {
	var timeDelta:Float;
	public function update(change:ChangeUniverseAfterTime) {
		change.time -= timeDelta;
		if(change.time <= 0) {
			Main.changeUniverse(change.universe);
		}
	} 
}