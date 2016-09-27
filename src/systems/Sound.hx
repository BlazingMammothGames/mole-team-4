package systems;

import edge.ISystem;
import edge.View;

class Sound implements ISystem {
	public function update(sound:components.Sound) {
		if(sound.play) {
			sound.howl.play();
			sound.play = false;
		}
	} 
}