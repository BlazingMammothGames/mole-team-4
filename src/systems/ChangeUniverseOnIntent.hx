package systems;

import edge.Entity;
import edge.ISystem;

class ChangeUniverseOnIntent implements ISystem {
	public function update(change:components.ChangeUniverseOnIntent) {
		if(Main.intended(change.intent))
			Main.changeUniverse(change.universe);
	} 
}