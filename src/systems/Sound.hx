package systems;

import edge.ISystem;
import edge.View;
import edge.Entity;

class Sound implements ISystem {
    public function updateAdded(entity:Entity, data:{sound:components.Sound}) {
        Main.universe.sounds.push(data.sound.howl);
    }

    public function updateRemoved(entity:Entity, data:{sound:components.Sound}) {
        Main.universe.sounds.remove(data.sound.howl);
    }

	public function update(sound:components.Sound) {
		if(sound.play) {
			sound.howl.play();
			sound.play = false;
		}
	} 
}