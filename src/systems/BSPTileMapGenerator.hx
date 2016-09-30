package systems;

import components.TileMap;
import edge.ISystem;
import edge.View;
import edge.Entity;

private class Rect {
	public var x:Int = 0;
	public var y:Int = 0;
	public var w:Int = 0;
	public var h:Int = 0;

	public var xmax(get, never):Int;
	private function get_xmax():Int {
		return x + w;
	}

	public var ymax(get, never):Int;
	private function get_ymax():Int {
		return y + h;
	}

	public function new(x:Int, y:Int, w:Int, h:Int) {
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
	}
}

private class BSP {
	public var parent:BSP = null;
	public var childA:BSP = null;
	public var childB:BSP = null;
	public var sibling:BSP = null;

	public var bounds:Rect;
	public var room:Rect;
	public var corridor:Rect;

	public function new(x:Int, y:Int, w:Int, h:Int, parent:BSP) {
		this.bounds = new Rect(x, y, w, h);
		this.parent = parent;
	}

	public function generate(minWidth:Int, minHeight:Int, maxAspect:Float, counter:Int) {
		if(counter <= 0) return;

		var x:Int = bounds.x;
		var y:Int = bounds.y;
		var w:Int = bounds.w;
		var h:Int = bounds.h;

		// intelligently choose our split direction,
		// trying to avoid extreme aspect ratios
		var ratio:Float = w / h;
		var direction:Int =
			if(ratio > maxAspect) 0; // split vertically
			else if(ratio < (1 / maxAspect)) 1; // split horizontally
			else Std.random(2); // split randomly

		if(direction == 0) {
			// split vertically
			var aWidth:Int = Std.random(w - (2 * minWidth)) + minWidth;
			var bWidth:Int = w - aWidth;

			if(aWidth < minWidth || bWidth < minWidth)
				return;

			childA = new BSP(x, y, aWidth, h, this);
			childB = new BSP(x + aWidth, y, bWidth, h, this);
		}
		else {
			// split horizontally
			var aHeight:Int = Std.random(h - (2 * minHeight)) + minHeight;
			var bHeight:Int = h - aHeight;

			if(aHeight < minHeight || bHeight < minHeight)
				return;

			childA = new BSP(x, y, w, aHeight, this);
			childB = new BSP(x, y + aHeight, w, bHeight, this);
		}

		// store the siblings
		childA.sibling = childB;
		childB.sibling = childA;

		// and continue recursively into each child
		childA.generate(minWidth, minHeight, maxAspect, counter - 1);
		childB.generate(minWidth, minHeight, maxAspect, counter - 1);
	}

	// recursively build the rooms
	public function buildRooms(minWidth:Int, minHeight:Int) {
		if(childA != null) {
			// recurse along until we find the leaves
			childA.buildRooms(minWidth, minHeight);
			childB.buildRooms(minWidth, minHeight);

			// don't build a room if we have children
			return;
		}

		// if we get here, we don't have children, so we're a leaf!
		
		// randomly size the room to fit the bounds
		var w:Int = Std.random(bounds.w - minWidth) + minWidth;
		var h:Int = Std.random(bounds.h - minHeight) + minHeight;

		// randomly place the room within the bounds
		var x:Int = Std.random(bounds.w - w) + bounds.x;
		var y:Int = Std.random(bounds.h - h) + bounds.y;

		// and build the room!
		this.room = new Rect(x, y, w, h);
	}

	// recursively build corridors
	public function buildCorridors() {
		if(childA == null) {
			if(room == null || sibling.room == null)
				return;

			// connect to our sibling leaf node!
			// find overlapping area
			var xMin:Int = sibling.room.x > room.x ? sibling.room.x : room.x;
			var xMax:Int = sibling.room.xmax < room.xmax ? sibling.room.xmax : room.xmax;
			var yMin:Int = sibling.room.y > room.y ? sibling.room.y : room.y;
			var yMax:Int = sibling.room.ymax < room.ymax ? sibling.room.ymax : room.ymax;

			if(xMax - xMin > 0) {
				// aligned walls along the horizontal
				// pick an x coordinate for the corridor
				var x:Int = Std.random(xMax - xMin) + xMin;
				// the width will be 1 as it will be a vertical corridor
				var w:Int = 1;
				// find the starting y pos
				var y:Int = sibling.room.y < room.y ? sibling.room.ymax : room.ymax;
				// find the ending y pos
				var y1:Int = sibling.room.y < room.y ? room.y : sibling.room.y;

				trace('Building vertical corridor at x=${x}, from y=${y}--${y1}');

				// build the corridor
				parent.corridor = new Rect(x, y, w, y1 - y);
			}
			else if(yMax - yMin > 0) {
				// aligned walls along the vertical
				// pick a y coordinate for the corridor
				var y:Int = Std.random(yMax - yMin) + yMin;
				// the height will be 1 as it will be a horizontal corridor
				var h:Int = 1;
				// find the starting x pos
				var x:Int = sibling.room.x < room.x ? sibling.room.xmax : room.xmax;
				// find the ending x pos
				var x1:Int = sibling.room.x < room.x ? room.x : sibling.room.x;

				trace('horizontal vertical corridor at y=${y}, from x=${x}--${x1}');

				// build the corridor
				parent.corridor = new Rect(x, y, x1 - x, h);
			}
			else {
				trace("unhandled corridor matching!");
			}
		}
		else {
			childA.buildCorridors();
			childB.buildCorridors();
		}
	}
}

class BSPTileMapGenerator implements ISystem {
	var entity:Entity;

	private function renderBSP(node:BSP, tileMap:TileMap):Void {
		// chheck the children
		if(node.childA != null) {
			renderBSP(node.childA, tileMap);
			renderBSP(node.childB, tileMap);
		}

		// render the room
		if(node.room != null) {
			for(y in node.room.y...(node.room.y+node.room.h)) {
				for(x in node.room.x...(node.room.x+node.room.w)) {
					tileMap.set(x, y, TTile.Floor);
				}
			}
		}

		// and the corridor
		if(node.corridor != null) {
			for(y in node.corridor.y...(node.corridor.y+node.corridor.h)) {
				for(x in node.corridor.x...(node.corridor.x+node.corridor.w)) {
					tileMap.set(x, y, TTile.Door);
				}
			}
		}
	}

	public function update(generator:components.BSPTileMapGenerator) {
		var tileMap:TileMap = new TileMap(generator.width, generator.height);

		// generate our BSP
		var root:BSP = new BSP(0, 0, generator.width, generator.height, null);
		root.generate(7, 7, 3, 30);

		// build rooms and corridors
		root.buildRooms(3, 3);
		root.buildCorridors();

		// render!
		renderBSP(root, tileMap);

		// swap the generator for the generated
		entity.remove(generator);
		entity.add(tileMap);
	} 
}