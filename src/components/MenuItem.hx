package components;

import edge.IComponent;

class MenuItem implements IComponent {
	public var index:Int;

	public function new(index:Int) {
		this.index = index;
	}
}