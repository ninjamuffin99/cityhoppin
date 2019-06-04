package player;

import flixel.input.touch.FlxTouch;
import flixel.FlxG;

class Player2Touch extends Player2ButtonBase
{
	override function movement():Void
	{
		var touch:FlxTouch;
		var left:Bool = false;
		var right:Bool = false;
		touch = getTouchPress();
		if(touch != null)
		{
			left = isTapLeft(touch);
			right = !left;
		}
		
		var leftR:Bool = false;
		var rightR:Bool = false;
		touch = getTouchJustReleased();
		if(touch != null)
		{
			leftR = isTapLeft(touch);
			rightR = !leftR;
		}
		
		var leftP:Bool = false;
		var rightP:Bool = false;
		touch = getTouchJustPressed();
		if(touch != null)
		{
			leftP = isTapLeft(touch);
			rightP = !leftP;
		}
		
		handleInput(left, right, leftR, rightR, leftP, rightP);
	}
	
	inline static public function getTouchPress():Null<FlxTouch>
	{
		var out:Null<FlxTouch> = null;
		for (touch in FlxG.touches.list)
			if(touch.pressed) {
				
				out = touch;
				break;
			}
		
		return out;
	}
	
	inline static public function getTouchJustPressed():Null<FlxTouch>
	{
		var out:Null<FlxTouch> = null;
		for (touch in FlxG.touches.justStarted()) {
			
			out = touch;
			break;
		}
		
		return out;
	}
	
	inline static public function getTouchJustReleased():Null<FlxTouch>
	{
		var out:Null<FlxTouch> = null;
		for (touch in FlxG.touches.justReleased()) {
			
			out = touch;
			break;
		}
		
		return out;
	}
	
	inline static public function isTapLeft(touch:FlxTouch):Bool
	{
		return touch.screenX <= FlxG.width / 2;
	}
}