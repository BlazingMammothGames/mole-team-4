package vellum;

import haxe.ds.ObjectMap;
import vellum.KeyBind;

@:generic
class Input<T> {
    private var bindings:ObjectMap<KeyBind, T> = new ObjectMap<KeyBind, T>();

    public function new() {}

    public function bind(binding:KeyBind, input:T) {
        bindings.set(binding, input);
    }

    public function check(keyCode:KeyCode, type:KeyEventType, shift:Bool, alt:Bool):T {
        for(b in bindings.keys()) {
            if(b.keyCode == keyCode && b.type == type && b.shift == shift && b.alt == alt)
                return bindings.get(b);
        }
        return null;
    }
}