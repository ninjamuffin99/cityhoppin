package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;

import com.newgrounds.*;
import com.newgrounds.components.*;

/**
 * ...
 * @author 
 */
class EndState extends FlxState 
{
	
	public static var time:Float = 5000;

	override public function create():Void 
	{
		FlxG.camera.fade(FlxColor.WHITE, 1, true);
		
		var bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height);
		add(bg);
		
		var txt:FlxText = new FlxText(0, 0, FlxG.width * 0.7, "gg wp \nmade by ninja_muffin99\nYou beat the game in ", 26);
		txt.text += Math.floor(time / 60) + "mins " + time % 60 + " seconds";
		txt.screenCenter();
		txt.color = FlxColor.BLACK;
		add(txt);
		
		super.create();
	}
	
}