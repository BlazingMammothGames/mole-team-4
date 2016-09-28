package;

import edge.Engine;
import edge.Phase;
import vellum.Input;

@:autoBuild(macros.Universes.name())
class Universe {
	public var engine:Engine = new Engine();
	public var update:Phase;
	public var render:Phase;
	public var input:Input<Intent> = new Input<Intent>();
	public var onPause:Array<Void->Void> = new Array<Void->Void>();
	public var onResume:Array<Void->Void> = new Array<Void->Void>();

	public function new() {
		update = engine.createPhase();
		render = engine.createPhase();
	}

	public function pause():Void {
		for(cb in onPause)
			cb();
	}

	public function resume():Void {
		for(cb in onResume)
			cb();
	}
}