package systems;

import edge.ISystem;
import edge.View;
import edge.Entity;

class Sound implements ISystem extends Pauseable {
	var updateItems:View<{sound:components.Sound}>;

	public function new(universe:Universe) {
		super(universe);
	}

	override public function onPause():Void {
		for(item in updateItems) {
			var sound:components.Sound = item.data.sound;
			if(sound.howl.playing()) {
				sound.howl.pause();
				sound.resume = true;
			}
		}
	}

	public function update(sound:components.Sound) {
		if(sound.play || sound.resume) {
			sound.howl.play();
			sound.play = false;
			sound.resume = false;
		}
	} 
}