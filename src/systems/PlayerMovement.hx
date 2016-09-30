package systems;

import components.PlayerControl;
import components.Position;
import edge.Entity;
import edge.ISystem;

class PlayerMovement implements ISystem {
	public function update(pos:Position, control:PlayerControl) {
		if(Main.intended(Intent.Up)) pos.y--;
		if(Main.intended(Intent.Right)) pos.x++;
		if(Main.intended(Intent.Down)) pos.y++;
		if(Main.intended(Intent.Left)) pos.x--;
	} 
}