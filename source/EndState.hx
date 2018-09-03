package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxMath;
import flixel.text.FlxText;

import com.newgrounds.*;
import com.newgrounds.components.*;

/**
 * ...
 * @author 
 */
class EndState extends FlxState 
{
	
	public static var time:Float = 0;

	override public function create():Void 
	{
		var bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height);
		add(bg);
		
		var txt:FlxText = new FlxText(0, 0, 0, "gg wp \nmade by ninja_muffin99\nYou beat the game in ", 32);
		txt.text += Math.round(time / 60) + "mins " + time % 60 + " seconds";
		txt.screenCenter();
		add(txt);
		
		super.create();
	}
	
}