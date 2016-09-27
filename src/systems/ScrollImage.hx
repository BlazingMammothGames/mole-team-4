package systems;

import edge.ISystem;
import edge.View;

class ScrollImage implements ISystem {
	var timeDelta:Float;

	public function update(image:components.Image, scroll:components.ScrollImage) {
		scroll.dY += scroll.speedY * timeDelta;
		while(Math.abs(scroll.dY) > 1) {
			var sign:Float = scroll.dY > 0 ? 1 : -1;
			image.y += Std.int(sign);
			scroll.dY -= sign;
		}

		if(image.y < scroll.minY) image.y = scroll.minY;
		if(image.y > scroll.maxY) image.y = scroll.maxY;
	} 
}