package systems;

import edge.Entity;
import edge.ISystem;

class ChangeUniverseOnIntent implements ISystem {
	public function update(change:components.ChangeUniverseOnIntent) {
		for(intent in Main.intents) {
			if(intent == change.intent)
				Main.changeUniverse(change.universe);
		}
	} 
}