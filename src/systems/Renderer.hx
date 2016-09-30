package systems;

import components.Position;
import components.Camera;
import components.TileMap;
import edge.ISystem;
import edge.View;
import vellum.Colour;
import vellum.Glyph;

class Renderer implements ISystem {
	var unknownGlyph:Glyph = new Glyph("?".charCodeAt(0), Colour.WHITE, Colour.DARKPURPLE);
	var clearGlyph:Glyph = new Glyph(" ".charCodeAt(0), Colour.BLACK, Colour.BLACK);
	var floorGlyph:Glyph = new Glyph(" ".charCodeAt(0), Colour.WHITE, Colour.DARKBROWN);
	var wallGlyph:Glyph = new Glyph("#".charCodeAt(0), Colour.BLACK, Colour.DARKBROWN);
	var doorGlyph:Glyph = new Glyph("H".charCodeAt(0), Colour.LIGHTBROWN, Colour.DARKBROWN);

	var tileMaps:View<{pos:Position, tiles:TileMap}>;

	public function update(pos:Position, cam:Camera) {
		for(tileMap in tileMaps) {
			for(cy in 0...cam.height) {
				for(cx in 0...cam.width) {
					var x:Int = cx + Std.int(pos.x);
					var y:Int = cy + Std.int(pos.y);
					if(x < 0 || y < 0 || x >= tileMap.data.tiles.width || y >= tileMap.data.tiles.height) {
						Main.term.drawGlyph(cx + cam.viewportX, cy + cam.viewportY, clearGlyph);
						continue;
					}

					Main.term.drawGlyph(
						cx + cam.viewportX,
						cy + cam.viewportY,
						switch(tileMap.data.tiles.map[y][x]) {
							case TTile.Floor: floorGlyph;
							case TTile.Wall: wallGlyph;
							case TTile.Door: doorGlyph;
							default: unknownGlyph;
						}
					);
				}
			}
		}
	} 
}