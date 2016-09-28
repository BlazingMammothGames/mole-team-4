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

	public function update(selector:MenuSelector, pos:Position) {
		// handle selector movement
		if(Main.intended(Intent.Previous) && selector.selection > 0)
			selector.selection--;
		if(Main.intended(Intent.Next) && selector.selection < maxIndex)
			selector.selection++;

		// handle menu selection
		if(Main.intended(Intent.Select)) {
			entity.engine.create([new components.Event(Events.DebugMessage("selected: " + selector.selection))]);
		}

		// re-position the selector
		for(item in menuItems) {
			if(selector.selection == item.data.menuItem.index) {
				pos.x = item.data.pos.x + selector.positionOffsetX;
				pos.y = item.data.pos.y + selector.positionOffsetY;
			}
		}
	}
}