package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var fisrtRun:Bool = true;
	
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState, 1));
	}
}
