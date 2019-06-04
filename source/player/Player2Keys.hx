package player;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

class Player2Keys extends Player2ButtonBase {
	
	override function movement():Void {
		
		var left :Array<FlxKey> = [LEFT, A];
		var right:Array<FlxKey> = [RIGHT, D];
		var keys = FlxG.keys;
		
		handleInput(
			keys.anyPressed(left),
			keys.anyPressed(right),
			keys.anyJustReleased(left),
			keys.anyJustReleased(right),
			keys.anyJustPressed(left),
			keys.anyJustPressed(right)
		);
	}
}