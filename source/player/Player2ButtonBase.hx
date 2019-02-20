package player;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxMath;

/**
 * ...
 * @author 
 */
class Player2ButtonBase extends Player 
{
	private function handleInput(
		left:Bool, right:Bool,
		leftR:Bool, rightR:Bool,
		leftP:Bool, rightP:Bool
	):Void
	{
		var up = left || right || !isTouching(FlxObject.FLOOR);
		var upR = leftR || rightR;
		
		if ( velocity.x > 0)
		{
			facing = FlxObject.RIGHT;
		}
		if ( velocity.x < 0)
		{
			facing = FlxObject.LEFT;
		}
		
		
		if (upR)
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
			
			if (up)
			{
				jumpsTotal += 1;
				
				if (jumpsTotal == 7)
				{
					//API.unlockMedal("the jump man");
				}
				
				velocity.y -= baseJumpStrength * 1.3;
				
				if (jumpCounts > 0)
				{
					jumpingCooldown = 0.8;
				}
				
				jumpCounts += 1;
				
				
				// old max height was 350;
				if (canJump)
				{
					if (left && right)
					{
						left = right = false;
						
					}
					else if (!left && !right)
					{
						velocity.x *= 0.77;
						jumpedStraightUp = true;
					}
					
					if (left || right)
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
					
					if (left)
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
					
					if (right)
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
			
			if (isTouching(FlxObject.CEILING))
			{
				apexReached = true;
			}
			
			if (up && !apexReached && canJump)
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
			
			if (upR)
			{
				apexReached = true;
			}
			
			
			if (left && right)
			{
				left = right = false;
			}
			
			var accX:Float = 2;
			
			if (jumpedStraightUp || sideBoosting)
				accX += 2.9;
			
			if (!justJumped)
			{
				apexReached = true;
				accX = 0.2;
			}
			
			if (left)
			{
				acceleration.x = -speed * accX;
			}
			
			if (right)
			{
				acceleration.x = speed * accX;
			}
			
			if (rightR || leftR)
			{
				jumpedStraightUp = false;
				acceleration.x = 0;
			}
			
			if (canSideBoost)
			{
				if (velocity.x > 0 && rightP && !jumpedStraightUp)
				{
					sideBoost = true;
				}
				if (velocity.x < 0 && leftP && !jumpedStraightUp)
				{
					sideBoost = true;
				}
			}
			
			if (velocity.x > 0 && leftP)
			{
				canSideBoost = false;
			}
			if (velocity.x < 0 && rightP)
			{
				canSideBoost = false;
			}
			
			drag.x = 0;
		}
	}
}