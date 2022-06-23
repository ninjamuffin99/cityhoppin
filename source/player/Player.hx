package player;

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
	private var justJumped:Bool = false;
	
	private var baseJumpStrength:Float = 100;
	private var jumpBoost:Float = 0;
	private var apexReached:Bool = false;
	private var jumpingCooldown:Float = 1;
	private var jumpCounts:Int = 0;
	private var canJump = false;
	
	private var sideBoost:Bool = false;
	private var sideBoosting:Bool = false;
	private var canSideBoost:Bool = false;
	
	private var jumpsTotal:Int = 0;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		//makeGraphic(32, 48);
		loadGraphic(AssetPaths.player__png, true , 40, 60);
		scale.set(2, 2);
		animation.add("stand", [0]);
		animation.add("jump", [1]);
		animation.add("dash", [3]);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		width -= 2 - 8;
		offset.x = 1;
		
		var hOff:Int = 15;
		
		height -= hOff;
		offset.y = hOff + 26;
		
		// drag.y = 1600;
		
		
		acceleration.y = 1500;
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		
		movement();
		super.update(elapsed);
	}
	
	private function movement():Void { }
	
	
	inline static public function createPlayer():Null<Player> {
		
		var type = getPlayerClass();
		
		return type == null ? null : Type.createInstance(type, []);
	}
	
	inline static public function getPlayerClass():Class<Player> {
		
		return
			#if FLX_NO_KEYBOARD
				#if two_button_mode Player2Touch #else PlayerSwipe #end
			#elseif FLX_NO_TOUCH
				#if two_button_mode Player2Keys #else Player4Keys #end
			#else
				if (FlxG.onMobile)
					#if two_button_mode Player2Touch #else PlayerSwipe #end
				else
					#if two_button_mode Player2Keys #else Player4Keys #end
			#end;
	}
}