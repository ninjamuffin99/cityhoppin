package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class EndState extends FlxSubState 
{
	
	public static var time:Float = 5000;
	
	private var bg:FlxSprite;
	private var txt:FlxText;
	#if use_newgrounds_api
	private var flashAd:FlashAd;
	#end
	
	override public function create():Void 
	{
		bg = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.5;
		bg.scrollFactor.set();
		add(bg);
		
		txt = new FlxText(50, 70, FlxG.width * 0.5, "gg wp \nmade by ninja_muffin99\nYou beat the game in ", 26);
		txt.text += Math.floor(EndState.time / 60) + "mins " + EndState.time % 60 + " seconds";
		txt.text += "\n\nPress Shift to toggle this overlay";
		txt.scrollFactor.set();
		add(txt);
		
		var visiButton:FlxButton = new FlxButton(40, FlxG.height - 50, "Toggle Overlay", function()
		{
			txt.visible = !txt.visible;
			bg.visible = txt.visible;
		});
			
		add(visiButton);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	
}