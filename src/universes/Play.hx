package universes;

import vellum.Input;
import vellum.KeyBind;
import vellum.KeyCode;
import vellum.KeyEventType;

class Play extends Universe {
    public function new() {
        super();

        input.bind(new KeyBind(KeyCode.up, KeyEventType.DOWN), Intent.Up);
        input.bind(new KeyBind(KeyCode.right, KeyEventType.DOWN), Intent.Right);
        input.bind(new KeyBind(KeyCode.down, KeyEventType.DOWN), Intent.Down);
        input.bind(new KeyBind(KeyCode.left, KeyEventType.DOWN), Intent.Left);

        update.add(new systems.TileMapGenerator());
        update.add(new systems.PlayerMovement());
        update.add(new systems.IntentEvent());
        update.add(new systems.ChangeUniverseEvent());
        render.add(new systems.Renderer());

        engine.create([
            new components.Position(0, 0),
            new components.TileMapGeneration(80, 30)
        ]);
        engine.create([
            new components.Position(0, 0),
            new components.Camera(0, 0, 60, 25),
            new components.PlayerControl()
        ]);
    }
}