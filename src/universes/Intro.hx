package universes;

import vellum.Input;
import vellum.KeyBind;
import vellum.KeyCode;
import vellum.KeyEventType;

class Intro extends Universe {
    public function new() {
        super();

        input.bind(new KeyBind(KeyCode.escape, KeyEventType.DOWN), Intent.Skip);
        input.bind(new KeyBind(KeyCode.enter, KeyEventType.DOWN), Intent.Skip);

        update.add(new systems.IntentEvent());
        update.add(new systems.ChangeUniverseEvent());
        render.add(new systems.TextRenderer());

        engine.create([
            new components.Text("No intro yet!"),
            new components.Position(0, 0)
        ]);
        engine.create([
            new components.Text("Press [ESC] to continue..."),
            new components.Position(Main.term.width - 26, Main.term.height - 1)
        ]);
        engine.create([new components.IntentEvent(Intent.Skip, TEvent.ChangeUniverse(MainMenu.name))]);
    }
}