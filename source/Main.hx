package;

import flixel.FlxGame;
import openfl.display.Sprite;
// import com.newgrounds.*;
// import com.newgrounds.components.*;

class Main extends Sprite
{
	public static var fisrtRun:Bool = true;
	
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState, 1));
		
		// API.connect(root, APIStuff.APIId, APIStuff.ENCKey);
		
		// var medal:MedalPopup = new MedalPopup();
		// medal.x = (stage.width / 2) - (medal.width / 2);
		// medal.y = 200;
		// addChild(medal);
	}
}
