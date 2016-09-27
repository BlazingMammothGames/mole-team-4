package;

import edge.Engine;
import edge.Entity;
import edge.Phase;
import haxe.ds.StringMap;
import howler.Howl;
import promhx.Deferred;
import vellum.DOSTerminal;
import vellum.Colour;

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
    public static var term:DOSTerminal;

    public static var universes:StringMap<Universe> = new StringMap<Universe>();
    public static var universe:Universe = null;

    #if debug
    private static var stats:Stats;
    #end

    public static function changeUniverse(verse:String):Universe {
        if(!universes.exists(verse)) throw 'Universe ${verse} doesn\' exist!';
        universe = universes.get(verse);
        js.Browser.console.log("Switch to universe '" + verse + "'!", universe);
        return universe;
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
        var splash:Universe = new Universe();
        splash.update.add(new systems.Kinematics());
        splash.update.add(new systems.KeepInBounds());
        splash.update.add(new systems.Sound());
        splash.update.add(new systems.ChangeUniverse());
        splash.render.add(new systems.ImageRenderer());
        splash.render.add(new systems.TextRenderer());
        universes.set("splash", splash);

        var intro:Universe = new Universe();
        intro.render.add(new systems.TextRenderer());
        universes.set("intro", intro);

        // set..
        splash.engine.create([
            new components.Image(Logo.src)
                .addMap(".", "#".charCodeAt(0), Colour.RED)
                .addMap(":", "#".charCodeAt(0), Colour.ORANGE)
                .addMap("%", "#".charCodeAt(0), Colour.YELLOW)
                .addMap("#", "#".charCodeAt(0), Colour.DARKGREY)
                .addMap("+", "#".charCodeAt(0), Colour.WHITE),
            new components.Position(23, 25),
            new components.Velocity(0, -64/3.3),
        ]);
        splash.engine.create([
            new components.Text("Blazing Mammoth Games", Colour.GOLD),
            new components.Position((80 - 21) / 2, 28+32),
            new components.Velocity(0, -64/3.3),
            new components.Bounds()
                .y(12, 100),
        ]);
        splash.engine.create([new components.Sound("blazingmammothgames.ogg", true, false)]);
        splash.engine.create([new components.ChangeUniverseAfterTime("intro", 5)]);

        intro.engine.create([
            new components.Text("Intro..."),
            new components.Position(0, 0)
        ]);

        // instantiate our terminal
        term = new DOSTerminal(80, 25);
        term.load().then(function(x:Bool) {
            // go!
            changeUniverse("splash");
            term.clear();
            Timing.onUpdate = onUpdate;
            Timing.onRender = onRender;
            Timing.start();
        });
    }

    private static function onUpdate(dt:Float) {
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
}