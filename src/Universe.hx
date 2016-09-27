package;

import edge.Engine;
import edge.Phase;

class Universe {
	public var engine:Engine;
	public var update:Phase;
	public var render:Phase;

	public function new() {
		engine = new Engine();
		update = engine.createPhase();
		render = engine.createPhase();
	}
}