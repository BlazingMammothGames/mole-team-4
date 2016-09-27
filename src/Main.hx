package;

import edge.Engine;
import edge.Phase;
import vellum.CanvasTerminal;

class Main {
    public static var term:CanvasTerminal;
    public static var engine:Engine;

    public static var updatePhase:Phase;
    public static var renderPhase:Phase;

    public static function main() {
        term = new CanvasTerminal(80, 25, vellum.Font.Menlo());

        // start your engines!
        engine = new Engine();
        updatePhase = engine.createPhase();
        renderPhase = engine.createPhase();

        // ready..
        // TODO: create systems

        // go!
        Timing.onUpdate = onUpdate;
        Timing.onRender = onRender;
        Timing.start();
    }

    private static function onUpdate(dt:Float) {
        updatePhase.update(dt);
    }

    private static function onRender(dt:Float, alpha:Float) {
        renderPhase.update(dt);
    }
}