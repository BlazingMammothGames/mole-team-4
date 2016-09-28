package components;

import edge.IComponent;

class MenuSelector implements IComponent {
	public var selection:Int;
	public var positionOffsetX:Int;
	public var positionOffsetY:Int;

	public function new(selection:Int) {
		this.selection = selection;
	}

	public function setOffset(x:Int, y:Int):MenuSelector {
		positionOffsetX = x;
		positionOffsetY = y;
		return this;
	}
}