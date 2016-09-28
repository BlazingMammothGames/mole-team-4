package vellum;

class KeyBind {
	public var keyCode:KeyCode;
	public var type:KeyEventType;
	public var shift:Bool;
	public var alt:Bool;

	public function new(keyCode:KeyCode, type:KeyEventType, ?shift:Bool, ?alt:Bool) {
		this.keyCode = keyCode;
		this.type = type;
		this.shift = shift != null && shift;
		this.alt = alt != null && alt;
	}
}
