package player;

import flixel.math.FlxMath;
import flixel.FlxObject;
import flixel.FlxG;

class Player4Keys extends Player
{
	override function movement():Void
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
		
		
		var _upP:Bool = false;
		var _downP:Bool = false;
		var _leftP:Bool = false;
		var _rightP:Bool = false;
		
		_upP = FlxG.keys.anyJustPressed([UP, W, SPACE]);
		_downP = FlxG.keys.anyJustPressed([DOWN, S]);
		_leftP = FlxG.keys.anyJustPressed([LEFT, A]);
		_rightP = FlxG.keys.anyJustPressed([RIGHT, D]);
		
		
		if ( velocity.x > 0)
		{
			facing = FlxObject.RIGHT;
		}
		if ( velocity.x < 0)
		{
			facing = FlxObject.LEFT;
		}
		
		
		if (_upR)
		{
			jumpingCooldown = 1;
			jumpCounts = 0;
		}
		
		if (justTouched(FlxObject.FLOOR))
		{
			FlxG.sound.play(AssetPaths.hitGround__wav, 0.7);
		}
		
		if (isTouching(FlxObject.FLOOR))
		{
			
			justJumped = false;
			apexReached = false;
			canJump = true;
			canSideBoost = true;
			sideBoosting = false;
			jumpBoost = 0;
			
			if (_up)
			{
				jumpsTotal += 1;
				
				#if use_newgrounds_api
				if (jumpsTotal == 7)
				{
					//API.unlockMedal("the jump man");
				}
				#end
				
				velocity.y -= baseJumpStrength * 1.3;
				
				if (jumpCounts > 0)
				{
					jumpingCooldown = 0.8;
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
						velocity.x *= 0.77;
						jumpedStraightUp = true;
					}
					
					if (_left || _right)
					{
						jumpedStraightUp = false;
						velocity.y -= baseJumpStrength * 0.2;
					}
					
					if (jumpedStraightUp)
					{
						sideBoost = false;
					}
					
					var oldVel = velocity.x;
					var reverseJumpMult:Float = 1.25;
					var xSlowdown:Float = 1.2;
					
					if (_left)
					{
						velocity.x = -speed;
						if (sideBoost && velocity.x - oldVel > velocity.x)
						{
							velocity.x = -maxVelocity.x;
							jumpingCooldown = 1;
							sideBoost = false;
							sideBoosting = true;
						}
						
						if (velocity.x - oldVel < velocity.x)
						{
							jumpingCooldown = reverseJumpMult;
							velocity.x /= reverseJumpMult * xSlowdown;
							FlxG.sound.play(AssetPaths.boost__wav, 0.7);
						}
					}
					
					if (_right)
					{
						velocity.x = speed;
						
						if (sideBoost && velocity.x + oldVel > velocity.x)
						{
							velocity.x = maxVelocity.x;
							jumpingCooldown = 1;
							sideBoost = false;
							sideBoosting = true;
						}
						
						if (velocity.x + oldVel < velocity.x)
						{
							jumpingCooldown = reverseJumpMult;
							velocity.x /= reverseJumpMult * xSlowdown;
							FlxG.sound.play(AssetPaths.boost__wav, 0.7);
						}
					}
					
					justJumped = true;
				}
				
			}
			
			if (!justJumped)
				animation.play("stand");
			else if (sideBoosting)
				FlxG.sound.play(AssetPaths.sideJump__wav, 0.7);
			else
				FlxG.sound.play(AssetPaths.jumpBase__wav, 0.7);
				
			
			drag.x = 1600 * 0.75;
			acceleration.x = 0;
			
			if (sideBoosting)
				maxVelocity.x = speed * 2;
			else
				maxVelocity.x = speed;
		
		}
		else
		{
			if (velocity.y < 0)
				animation.play("jump");
			if (sideBoosting)
				animation.play("dash");
			
			
			if (_down)
			{
				apexReached = true;
				velocity.y += 10;
			}
			
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
					//FlxG.watch.addQuick("cosine", C);
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
			
			var accX:Float = 1.4;
			
			if (jumpedStraightUp || sideBoosting)
				accX += 2.9;
			
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
				acceleration.x = 0;
			}
			
			if (canSideBoost)
			{
				if (velocity.x > 0 && _rightP && !jumpedStraightUp)
				{
					sideBoost = true;
				}
				if (velocity.x < 0 && _leftP && !jumpedStraightUp)
				{
					sideBoost = true;
				}
			}
			
			if (velocity.x > 0 && _leftP)
			{
				canSideBoost = false;
			}
			if (velocity.x < 0 && _rightP)
			{
				canSideBoost = false;
			}
			
			drag.x = 0;
		}
	}
}