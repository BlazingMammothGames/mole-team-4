package universes;

import vellum.Colour;
import vellum.Input;
import vellum.KeyBind;
import vellum.KeyCode;
import vellum.KeyEventType;

class Splash extends Universe {
    public function new() {
        super();

        input.bind(new KeyBind(KeyCode.escape, KeyEventType.DOWN), Intent.Skip);

        update.add(new systems.Kinematics());
        update.add(new systems.KeepInBounds());
        update.add(new systems.Sound());
        update.add(new systems.ChangeUniverseAfterTime());

        render.add(new systems.ImageRenderer());
        render.add(new systems.TextRenderer());

        engine.create([
            new components.Image(Logo.src)
                .addMap(".", "#".charCodeAt(0), Colour.RED)
                .addMap(":", "#".charCodeAt(0), Colour.ORANGE)
                .addMap("%", "#".charCodeAt(0), Colour.YELLOW)
                .addMap("#", "#".charCodeAt(0), Colour.DARKGREY)
                .addMap("+", "#".charCodeAt(0), Colour.WHITE),
            new components.Position(23, 25),
            new components.Velocity(0, -64/3.3),
        ]);
        engine.create([
            new components.Text("Blazing Mammoth Games", Colour.GOLD),
            new components.Position((80 - 21) / 2, 28+32),
            new components.Velocity(0, -64/3.3),
            new components.Bounds()
                .y(12, 100),
        ]);
        engine.create([new components.Sound("blazingmammothgames.ogg", true, false)]);
        engine.create([new components.ChangeUniverseAfterTime("intro", 5)]);

        registerIntent(Intent.Skip, function() {
            Main.changeUniverse("intro");
        });
    }
}