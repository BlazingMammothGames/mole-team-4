package components;

import edge.IComponent;
import haxe.ds.StringMap;
import vellum.Colour;
import vellum.Glyph;

class Image implements IComponent {
	public var lines:Array<String>;
	public var x:Int;
	public var y:Int;
	public var map:StringMap<Glyph> = new StringMap<Glyph>();

	public function new(src:String, ?x:Int, ?y:Int) {
		this.lines = src.split("\n");
		this.x = x == null ? 0 : x;
		this.y = y == null ? 0 : y;
	}

	public function addMap(char:String, ?code:Int, ?fore:Colour, ?back:Colour):Image {
		map.set(char, new Glyph(code == null ? char.charCodeAt(0) : code, fore, back));
		return this;
	}
}