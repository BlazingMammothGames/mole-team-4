package systems;

import edge.ISystem;
import edge.View;
import vellum.Glyph;

using Lambda;

class Image implements ISystem {
	public function update(image:components.Image) {
		var x:Int = image.x;
		var y:Int = image.y;
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