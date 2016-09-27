package vellum;

class Font {
	public var family:String;
	public var size:Int;
	public var charWidth:Float;
	public var extraWidth:Float;
	public var lineHeight:Float;
	public var x:Float;
	public var y:Float;

	public function new(family:String, size:Int) {
		this.family = family;
		this.size = size;
	}

	@SuppressWarnings('checkstyle:MagicNumber', 'checkstyle:MethodName')
	public static function Courier():Font {
		return new Font('Courier', 13);
	}

	@SuppressWarnings('checkstyle:MagicNumber', 'checkstyle:MethodName')
	public static function Menlo():Font {
		return new Font('Menlo, Consolas', 12);
	}

	@SuppressWarnings('checkstyle:MagicNumber', 'checkstyle:MethodName')
	public static function Monospace():Font {
		return new Font('monospace', 12);
	}
}
