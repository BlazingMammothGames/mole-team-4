package universes;

import vellum.Input;
import vellum.KeyBind;
import vellum.KeyCode;
import vellum.KeyEventType;

class MainMenu extends Universe {
    public function new() {
        super();

        input.bind(new KeyBind(KeyCode.enter, KeyEventType.DOWN), Intent.Select);

        input.bind(new KeyBind(KeyCode.up, KeyEventType.DOWN), Intent.Previous);
        input.bind(new KeyBind(KeyCode.w, KeyEventType.DOWN), Intent.Previous);
        input.bind(new KeyBind(KeyCode.left, KeyEventType.DOWN), Intent.Previous);
        input.bind(new KeyBind(KeyCode.a, KeyEventType.DOWN), Intent.Previous);
        input.bind(new KeyBind(KeyCode.down, KeyEventType.DOWN), Intent.Next);
        input.bind(new KeyBind(KeyCode.s, KeyEventType.DOWN), Intent.Next);
        input.bind(new KeyBind(KeyCode.right, KeyEventType.DOWN), Intent.Next);
        input.bind(new KeyBind(KeyCode.d, KeyEventType.DOWN), Intent.Next);

        update.add(new systems.Menu());
        update.add(new systems.DebugEvent());
        update.add(new systems.ChangeUniverseEvent());
        render.add(new systems.TextRenderer());

        engine.create([
            new components.Text("== Main Menu ==", vellum.Colour.GOLD),
            new components.Position((Main.term.width - 15) / 2, 1)
        ]);

        engine.create([
        	new components.Text(">", vellum.Colour.GOLD),
        	new components.MenuSelector(0)
        		.setOffset(-2, 0),
        	new components.Position(0, 0)
        ]);

        engine.create([
        	new components.Text("Start"),
        	new components.Position(3, 3),
        	new components.MenuItem(0, TEvent.ChangeUniverse(Play.name))
        ]);

        engine.create([
        	new components.Text("Options"),
        	new components.Position(3, 4),
        	new components.MenuItem(1, TEvent.DebugMessage("TODO: handle 'Options' action!"))
        ]);

        engine.create([
        	new components.Text("Credits"),
        	new components.Position(3, 5),
        	new components.MenuItem(2, TEvent.DebugMessage("TODO: handle 'Credits' action!"))
        ]);

        engine.create([
        	new components.Text("Quit"),
        	new components.Position(Main.term.width - 6, Main.term.height - 2),
        	new components.MenuItem(3, TEvent.DebugMessage("TODO: handle 'Quit' action!"))
        ]);
    }
}