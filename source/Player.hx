package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author 
 */
class Player extends FlxSprite 
{

	public var speed:Float = 200;
	
	private var jumpedStraightUp:Bool = true;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		makeGraphic(32, 48);
		
		drag.y = 1600;
		maxVelocity.x = speed * 1.1;
		
		acceleration.y = 700;
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		
		movement();
		super.update(elapsed);
	}
	
	private function movement():Void
	{
		var _up:Bool = false;
		var _down:Bool = false;
		var _left:Bool = false;
		var _right:Bool = false;
		
		_up = FlxG.keys.anyPressed([UP, W, SPACE]);
		_down = FlxG.keys.anyPressed([DOWN, S]);
		_left = FlxG.keys.anyPressed([LEFT, A]);
		_right = FlxG.keys.anyPressed([RIGHT, D]);
		
		var _upR:Bool = false;
		var _downR:Bool = false;
		var _leftR:Bool = false;
		var _rightR:Bool = false;
		
		_upR = FlxG.keys.anyJustReleased([UP, W, SPACE]);
		_downR = FlxG.keys.anyJustReleased([DOWN, S]);
		_leftR = FlxG.keys.anyJustReleased([LEFT, A]);
		_rightR = FlxG.keys.anyJustReleased([RIGHT, D]);
		
		
		if (isTouching(FlxObject.FLOOR))
		{
			if (_up)
			{
				velocity.y -= 300;
				
				if (_left && _right)
				{
					_left = _right = false;
				}
				else if (!_left && !_right)
					jumpedStraightUp = true;
				
				if (_left)
				{
					velocity.x = -speed;
					
					jumpedStraightUp = false;
				}
				
				if (_right)
				{
					velocity.x = speed;
					jumpedStraightUp = false;
				}
			}
			
			drag.x = drag.y * 0.5;
			acceleration.x = 0;
		}
		else
		{
			
			
			if (_left && _right)
			{
				_left = _right = false;
			}
			
			var accX:Float = 0.97;
			
			if (jumpedStraightUp)
				accX += 2.8;
			
			if (_left)
			{
				acceleration.x = -speed * accX;
			}
			
			if (_right)
			{
				acceleration.x = speed * accX;
			}
			
			if (_rightR || _leftR)
			{
				jumpedStraightUp = false;
			}
			
			drag.x = 0;
		}
	}
	
}