package components;

import edge.IComponent;
import howler.Howl;
import howler.Howl.HowlOptions;

class Sound implements IComponent {
	public var howl:Howl;
	public var soundID:Int;

	public var loop:Bool;
	public var play:Bool;
	public var playing:Bool;
	public var playCount:Int;

	public function new(src:String, play:Bool, loop:Bool) {
		this.loop = loop;
		this.play = play;
		this.playing = false;
		this.playCount = 0;

		howl = new Howl({
			src: [src],
			autoplay: false,
			loop: loop,
			onplay: function(id:Int) {
				playing = true;
				soundID = id;
			},
			onend: function(id:Int) {
				playCount++;
				playing = howl.loop();
			}
		});
	}
}