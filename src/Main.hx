package;

import edge.Engine;
import edge.Entity;
import edge.Phase;
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
    public static var engine:Engine;

    public static var updatePhase:Phase;
    public static var renderPhase:Phase;

    private static var logo:Entity;

    #if debug
    private static var stats:Stats;
    #end

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

        term = new DOSTerminal(80, 25);

        term.load().then(function(x:Bool) {
            // show a loading screen
            term.clear();
            Timing.start();
        });

        // start your engines!
        engine = new Engine();
        updatePhase = engine.createPhase();
        renderPhase = engine.createPhase();

        // ready..
        updatePhase.add(new systems.DestroyAfterTime());
        updatePhase.add(new systems.ScrollImage());
        updatePhase.add(new systems.Sound());
        renderPhase.add(new systems.Image());

        // set..
        logo = engine.create([
            new components.Image(Logo.src, 23, 0)
                .addMap(".", "#".charCodeAt(0), Colour.RED)
                .addMap(":", "#".charCodeAt(0), Colour.ORANGE)
                .addMap("%", "#".charCodeAt(0), Colour.YELLOW)
                .addMap("#", "#".charCodeAt(0), Colour.DARKGREY)
                .addMap("+", "#".charCodeAt(0), Colour.WHITE),
            new components.ScrollImage(-10 / 1, -10, 0),
            new components.Sound("blazingmammothgames.ogg", true, false),
            new components.DestroyAfterTime(5)
        ]);

        // go!
        Timing.onUpdate = onUpdate;
        Timing.onRender = onRender;
    }

    private static function onUpdate(dt:Float) {
        updatePhase.update(dt);
    }

    private static function onRender(dt:Float, alpha:Float) {
        term.clear();
        renderPhase.update(dt);
        term.render();

        #if debug
        if(stats != null) stats.update();
        #end
    }
}