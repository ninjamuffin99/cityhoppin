package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author 
 */
class Player extends FlxSprite 
{

	public var speed:Float = 200;
	
	private var jumpedStraightUp:Bool = true;
	private var justJumped:Bool = false;
	
	private var baseJumpStrength:Float = 100;
	private var jumpBoost:Int = 0;
	private var apexReached:Bool = false;
	private var jumpingCooldown:Float = 1;
	private var jumpCounts:Int = 0;
	private var canJump = false;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		makeGraphic(32, 48);
		
		// drag.y = 1600;
		maxVelocity.x = speed * 1.1;
		
		acceleration.y = 1500;
		
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
		
		if (_upR)
		{
			jumpingCooldown = 1;
			jumpCounts = 0;
		}
		
		if (isTouching(FlxObject.FLOOR))
		{
			justJumped = false;
			apexReached = false;
			canJump = true;
			jumpBoost = 0;
			
			if (_up)
			{
				
				velocity.y -= baseJumpStrength * 1.3;
				
				if (jumpCounts > 0)
				{
					jumpingCooldown = 0.75;
				}
				
				jumpCounts += 1;
				
				
				// old max height was 350;
				if (canJump)
				{
					if (_left && _right)
					{
						_left = _right = false;
						
					}
					else if (!_left && !_right)
					{
						velocity.x *= 0.8;
						jumpedStraightUp = true;
					}
					
					if (_left || _right)
					{
						jumpedStraightUp = false;
						velocity.y -= baseJumpStrength * 0.2;
					}
					
					if (_left)
					{
						velocity.x = -speed;
					}
					
					if (_right)
					{
						velocity.x = speed;
					}
					
					justJumped = true;
				}
				
			}
			
			drag.x = 1600 * 0.5;
			acceleration.x = 0;
		}
		else
		{
			if (isTouching(FlxObject.CEILING))
			{
				apexReached = true;
			}
			
			if (_up && !apexReached && canJump)
			{
				jumpBoost++;
				
				var C = FlxMath.fastCos(13 * jumpBoost * FlxG.elapsed);
				if (C < 0)
				{
					apexReached = true;
				}
				else
				{
					velocity.y -= C * (baseJumpStrength * 1.2) * jumpingCooldown;
					FlxG.watch.addQuick("cosine", C);
				}
			}
			
			if (_upR)
			{
				apexReached = true;
			}
			
			
			if (_left && _right)
			{
				_left = _right = false;
			}
			
			var accX:Float = 0.97;
			
			if (jumpedStraightUp)
				accX += 2.8;
			
			if (!justJumped)
			{
				apexReached = true;
				accX = 0.2;
			}
			
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