package components;

import edge.IComponent;

class ChangeUniverseOnIntent implements IComponent {
	public var universe:String;
	public var intent:Intent;

	public function new(universe:String, intent:Intent) {
		this.universe = universe;
		this.intent = intent;
	}
}