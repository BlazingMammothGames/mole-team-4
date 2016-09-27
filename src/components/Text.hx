package components;

import edge.IComponent;
import vellum.Colour;

class Text implements IComponent {
	public var text:String;
	public var foreground:Colour;
	public var background:Colour;

	public function new(text:String, ?foreground:Colour, ?background:Colour) {
		this.text = text;
		this.foreground = foreground;
		this.background = background;
	}
}