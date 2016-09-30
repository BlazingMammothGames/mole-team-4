package components;

import edge.IComponent;
import haxe.ds.StringMap;
import vellum.Colour;
import vellum.Glyph;

using StringTools;

class Image implements IComponent {
	public var lines:Array<String>;
	public var map:StringMap<Glyph> = new StringMap<Glyph>();

	public function new(src:String) {
		this.lines = src.trim().split("\n");
	}

	public function addMap(char:String, ?code:Int, ?fore:Colour, ?back:Colour):Image {
		map.set(char, new Glyph(code == null ? char.charCodeAt(0) : code, fore, back));
		return this;
	}
}