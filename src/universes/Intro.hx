package universes;

class Intro extends Universe {
    public function new() {
        super();

        render.add(new systems.TextRenderer());

        engine.create([
            new components.Text("Intro..."),
            new components.Position(0, 0)
        ]);
    }
}