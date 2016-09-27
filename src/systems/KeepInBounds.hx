package systems;

import components.Bounds;
import components.Position;
import edge.Entity;
import edge.ISystem;

class KeepInBounds implements ISystem {
	public function update(pos:Position, bounds:Bounds) {
		if(bounds.minX != null && pos.x < bounds.minX) pos.x = bounds.minX;
		if(bounds.maxX != null && pos.x > bounds.maxX) pos.x = bounds.maxX;
		if(bounds.minY != null && pos.y < bounds.minY) pos.y = bounds.minY;
		if(bounds.maxY != null && pos.y > bounds.maxY) pos.y = bounds.maxY;
		if(bounds.minZ != null && pos.z < bounds.minZ) pos.z = bounds.minZ;
		if(bounds.maxZ != null && pos.z > bounds.maxZ) pos.z = bounds.maxZ;
	} 
}