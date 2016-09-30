package;

import haxe.ds.StringMap;
import howler.Howl;
import promhx.Deferred;
import vellum.DOSTerminal;
import vellum.KeyCode;
import vellum.KeyEventType;

#if debug
@:native("Stats")
extern class Stats {
  public var REVISION(default, null):Int;
  public var dom(default, null):js.html.DivElement;

  public function new();

  public function begin():Void;
  public function end():Void;
  public function update():Void;
  public function setMode(value:Int):Void;
}
#end

class Main {
    public static var console:js.html.Console = js.Browser.console;
    public static var term:DOSTerminal;
    private static var _universes:StringMap<Universe> = new StringMap<Universe>();
    public static var universe:Universe = null;

    private static var intents:Array<Intent> = new Array<Intent>();
    private static var tempIntents:Array<Intent> = new Array<Intent>();

    public static function intended(intent:Intent) {
        return intents.indexOf(intent) > -1;
    }

    #if debug
    private static var stats:Stats;
    #end

    public static function changeUniverse(verse:String):Void {
        if(!_universes.exists(verse)) throw 'Universe ${verse} doesn\'t exist!';
        if(universe != null) universe.pause();
        universe = _universes.get(verse);
        universe.resume();
    }

    public static function main() {
        // add stats
        #if debug
        var script:js.html.ScriptElement = js.Browser.document.createScriptElement();
        script.onload = function() {
            stats = new Stats();
            js.Browser.document.body.appendChild(stats.dom);
        };
        script.src = "//rawgit.com/mrdoob/stats.js/master/build/stats.min.js";
        js.Browser.document.head.appendChild(script);
        #end

        // ready..
        term = new DOSTerminal(80, 25);
        term.onInputEvent = handleInput;
        
        _universes.set(universes.Splash.name, new universes.Splash());
        _universes.set(universes.Intro.name, new universes.Intro());
        _universes.set(universes.MainMenu.name, new universes.MainMenu());
        _universes.set(universes.Play.name, new universes.Play());

        // set..
        term.load().then(function(x:Bool) {
            // go!
            changeUniverse(universes.Play.name);
            term.clear();
            Timing.onUpdate = onUpdate;
            Timing.onRender = onRender;
            Timing.start();
        });
    }

    private static function onUpdate(dt:Float) {
        intents = tempIntents;
        tempIntents = new Array<Intent>();
        universe.update.update(dt);
    }

    private static function onRender(dt:Float, alpha:Float) {
        term.clear();
        universe.render.update(dt);
        term.render();

        #if debug
        if(stats != null) stats.update();
        #end
    }

    private static function handleInput(code:KeyCode, type:KeyEventType, shift:Bool, alt:Bool):Bool {
        var intent:Intent = universe.input.check(code, type, shift, alt);
        if(intent != null) {
            tempIntents.push(intent);
            return true;
        }
        return false;
    }
}