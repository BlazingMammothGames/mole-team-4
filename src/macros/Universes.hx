package macros;

import haxe.macro.Context;
import haxe.macro.Expr;

class Universes {
	macro public static function name():Array<Field> {
		var fields:Array<Field> = Context.getBuildFields();

		fields.push({
			name: "name",
			doc: "The universe's name",
			access: [Access.APublic, Access.AStatic, Access.AInline],
			pos: Context.currentPos(),
			kind: FieldType.FVar(macro: String, macro $v{Context.getLocalClass().get().name})
		});

		return fields;
	}
}