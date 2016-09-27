package systems;

import components.Image;
import components.Position;
import edge.ISystem;
import edge.View;
import vellum.Glyph;

using Lambda;

class ImageRenderer implements ISystem {
	public function update(pos:Position, image:Image) {
		var x:Int = Std.int(pos.x);
		var y:Int = Std.int(pos.y);
		for(line in image.lines) {
			var glyphs:Array<Glyph> = new Array<Glyph>();
			for(i in 0...line.length) {
				if(image.map.exists(line.charAt(i)))
					glyphs.push(image.map.get(line.charAt(i)));
				else
					glyphs.push(new Glyph(line.charCodeAt(i)));
			}
			Main.term.printGlyphs(x, y, glyphs);
			y++;
		}
	} 
}