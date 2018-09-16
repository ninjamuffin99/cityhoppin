package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class EndState extends FlxSubState 
{
	
	public static var time:Float = 5000;

	override public function create():Void 
	{
		var bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.5;
		add(bg);
		
		var txt:FlxText = new FlxText(0, 0, FlxG.width * 0.7, "gg wp \nmade by ninja_muffin99\nYou beat the game in ", 26);
		txt.text += Math.floor(time / 60) + "mins " + time % 60 + " seconds";
		txt.screenCenter();
		add(txt);
		
		super.create();
	}
	
}