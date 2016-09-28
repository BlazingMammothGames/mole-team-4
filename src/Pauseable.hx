package;

class Pauseable {
	public function new(universe:Universe) {
		universe.onResume.push(this.onResume);
		universe.onPause.push(this.onPause);
	}

	public function onResume():Void {}
	public function onPause():Void {}
}