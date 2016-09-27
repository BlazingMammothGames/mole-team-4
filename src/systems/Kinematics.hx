package systems;

import components.Position;
import components.Velocity;
import edge.ISystem;
import edge.View;

class Kinematics implements ISystem {
	var timeDelta:Float;

	public function update(pos:Position, vel:Velocity) {
		pos.x += vel.vx * timeDelta;
		pos.y += vel.vy * timeDelta;
	} 
}