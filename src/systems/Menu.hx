package systems;

import components.MenuItem;
import components.MenuSelector;
import components.Position;
import edge.ISystem;
import edge.View;
import edge.Entity;

class Menu implements ISystem {
	var maxIndex:Int = 0;
	var menuItems:View<{menuItem:MenuItem, pos:Position}>;
	var entity:Entity;

	public function menuItemsAdded(entity:Entity, data:{menuItem:MenuItem, pos:Position}) {
		if(data.menuItem.index > maxIndex)
			maxIndex = data.menuItem.index;
	}

	public function menuItemsRemoved(entity:Entity, data:{menuItem:MenuItem, pos:Position}) {
		maxIndex = 0;
		for(item in menuItems) {
			if(item.data.menuItem.index > maxIndex)
				maxIndex = item.data.menuItem.index;
		}
	}

	private function getSelection(selection:Int):{menuItem:MenuItem, pos:Position} {
		for(item in menuItems) {
			if(selection == item.data.menuItem.index)
				return item.data;
		}
		return null;
	}

	public function update(selector:MenuSelector, pos:Position) {
		// handle selector movement
		if(Main.intended(Intent.Previous) && selector.selection > 0)
			selector.selection--;
		if(Main.intended(Intent.Next) && selector.selection < maxIndex)
			selector.selection++;

		// handle menu selection
		if(Main.intended(Intent.Select)) {
			entity.engine.create([new components.Event(getSelection(selector.selection).menuItem.event)]);
		}

		// re-position the selector
		var selected:{menuItem:MenuItem, pos:Position} = getSelection(selector.selection);
		pos.x = selected.pos.x + selector.positionOffsetX;
		pos.y = selected.pos.y + selector.positionOffsetY;
	}
}