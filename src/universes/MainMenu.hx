package universes;

import vellum.Input;
import vellum.KeyBind;
import vellum.KeyCode;
import vellum.KeyEventType;

class MainMenu extends Universe {
    public function new() {
        super();

        input.bind(new KeyBind(KeyCode.escape, KeyEventType.DOWN), Intent.Back);

        render.add(new systems.TextRenderer());

        engine.create([
            new components.Text("== Main Menu =="),
            new components.Position((Main.term.width - 15) / 2, 0)
        ]);
    }
}