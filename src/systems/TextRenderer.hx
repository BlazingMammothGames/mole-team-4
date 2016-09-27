package systems;

import components.Position;
import components.Text;
import edge.ISystem;

class TextRenderer implements ISystem {
	public function update(pos:Position, text:Text) {
		Main.term.print(Std.int(pos.x), Std.int(pos.y), text.text, text.foreground, text.background);
	} 
}