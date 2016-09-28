package;

import edge.Engine;
import edge.Phase;
import haxe.ds.EnumValueMap;
import howler.Howl;
import vellum.Input;

class Universe {
	public var engine:Engine = new Engine();
	public var update:Phase;
	public var render:Phase;
	public var input:Input<Intent> = new Input<Intent>();
	public var intents:EnumValueMap<Intent, Array<Void->Void>> = new EnumValueMap<Intent, Array<Void->Void>>();
	public var onPause:Array<Void->Void> = new Array<Void->Void>();
	public var onResume:Array<Void->Void> = new Array<Void->Void>();
	public var paused:Bool = true;
	public var sounds:Array<Howl> = new Array<Howl>();

	public function new() {
		update = engine.createPhase();
		render = engine.createPhase();
	}

	public function registerIntent(intent:Intent, cb:Void->Void):Void {
		if(!intents.exists(intent)) intents.set(intent, new Array<Void->Void>());
		intents.get(intent).push(cb);
	}

	public function registerOnPause(cb:Void->Void):Void {
		onPause.push(cb);
	}

	public function registerOnResume(cb:Void->Void):Void {
		onResume.push(cb);
	}

	public function handleIntent(intent:Intent):Void {
		if(!intents.exists(intent)) return;
		for(cb in intents.get(intent)) {
			cb();
		}
	}

	public function pause():Void {
		paused = true;
		for(cb in onPause)
			cb();
		for(howl in sounds) {
			howl.pause();
		}
	}

	public function resume():Void {
		paused = false;
		for(cb in onResume)
			cb();
	}
}