#if js

package vellum;

import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.ImageElement;

import promhx.Deferred;
import promhx.Promise;

import haxe.ds.StringMap;
import vellum.Colour;
import vellum.KeyCode;
import vellum.KeyEventType;

class DOSTerminal extends RenderableTerminal {
	var font:Font;
	var canvas:CanvasElement;
	var context:CanvasRenderingContext2D;
	var fontImage:ImageElement;
	var imageLoaded:Bool = false;
	var d:Deferred<Bool> = new Deferred<Bool>();
	var fontColourCache:StringMap<CanvasElement> = new StringMap<CanvasElement>();
	
	public var onInputEvent:KeyCode->KeyEventType->Bool->Bool->Bool;

	override public function set_handlingInput(x:Bool):Bool {
		js.Browser.document.body.onkeydown = x ? onKeyDown : null;
		js.Browser.document.body.onkeyup = x ? onKeyUp : null;
		js.Browser.document.body.onkeypress = x ? onKeyPress : null;
		handlingInput = x;
		return handlingInput;
	}

	override public function set_width(w:Int):Int {
		super.set_width(w);
		resizeCanvas();
		return width;
	}

	override public function set_height(h:Int):Int {
		super.set_height(h);
		resizeCanvas();
		return height;
	}

	function resizeCanvas() {
		canvas.width = Math.ceil(font.charWidth * width);
		canvas.height = Math.ceil(font.lineHeight * height);
		canvas.style.width = '${canvas.width}px';
		canvas.style.height = '${canvas.height}px';
	}

	public function load():Promise<Bool> {
		return d.promise();
	}

	public function new(width:Int, height:Int, ?canvas:CanvasElement, ?handleInput:Bool) {
		// initialize the display
		super(width, height);

		// create a canvas to draw on if we don't have one
		if(canvas == null) {
			canvas = js.Browser.document.createCanvasElement();
			js.Browser.window.document.body.appendChild(canvas);
		}
		this.canvas = canvas;
		this.context = canvas.getContext2d();

		context.font = '${12 * js.Browser.window.devicePixelRatio}px monospace';
		context.fillStyle = "#fff";
		context.fillText(
			"Loading...",
			(canvas.width - context.measureText("Loading...").width) / 2,
			(canvas.height - 18) / 2
		);

		// load the font image
		fontImage = js.Browser.document.createImageElement();
		fontImage.src = "dos-short.png";
		fontImage.onload = function(_) {
			imageLoaded = true;
			d.resolve(true);
		}

		// setup the font
		font = new Font("dos", 8);
		font.charWidth = 9;
		font.lineHeight = 13;
		font.x = 0;
		font.y = 0;

		// size the canvas appropriately
		resizeCanvas();

		// enable input handling (by default)
		handlingInput = handleInput == null ? true : handleInput;
	}

	function onKeyDown(event:js.html.KeyboardEvent) {
		onKeyEvent(event, KeyEventType.DOWN);
	}

	function onKeyUp(event:js.html.KeyboardEvent) {
		onKeyEvent(event, KeyEventType.UP);
	}

	function onKeyPress(event:js.html.KeyboardEvent) {
		onKeyEvent(event, KeyEventType.PRESSED);
	}

	function onKeyEvent(event:js.html.KeyboardEvent, type:KeyEventType) {
		// grab the keycode
		// firefox uses 59 for semicolon
		var keyCode:KeyCode = event.keyCode == 59 ? KeyCode.semicolon : cast(event.keyCode);

		// send the event to the input handler
		if(onInputEvent != null) {
			if(onInputEvent(keyCode, type, event.shiftKey, event.altKey))
				event.preventDefault();
		}
	}

	override public function drawGlyph(x:Int, y:Int, glyph:Glyph) {
		if(!imageLoaded) return;

		// draw the background
		context.fillStyle = cast(glyph.background);
		context.fillRect(
			x * font.charWidth,
			y * font.lineHeight,
			font.charWidth,
			font.lineHeight
		);

		// don't draw empty chars
		if(glyph.code == 0 || glyph.code == ' '.charCodeAt(0)) return;

		// get our source pos
		var sx:Float = (glyph.code % 32) * font.charWidth;
		var sy:Float = Std.int(glyph.code / 32) * font.lineHeight;

		// and our cached colour
		var colouredFont:CanvasElement = getColouredFont(glyph.foreground);

		context.drawImage(
			colouredFont,
			sx, sy, font.charWidth, font.lineHeight,
			x * font.charWidth, y * font.lineHeight, font.charWidth, font.lineHeight
		);
	}

	private function getColouredFont(colour:Colour):CanvasElement {
		if(fontColourCache.exists(cast colour))
			return fontColourCache.get(cast colour);

		// tint the base font into the colour
		var tint:CanvasElement = js.Browser.document.createCanvasElement();
		tint.width = fontImage.width;
		tint.height = fontImage.height;
		var ctx:CanvasRenderingContext2D = tint.getContext2d();

		// draw the font
		ctx.drawImage(fontImage,  0, 0);

		// tint it
		ctx.globalCompositeOperation = "source-atop";
		ctx.fillStyle = cast(colour);
		ctx.fillRect(0, 0, fontImage.width, fontImage.height);

		fontColourCache.set(cast colour, tint);
		return tint;
	}
}

#end