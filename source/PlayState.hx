package;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

import com.newgrounds.*;
import com.newgrounds.components.*;

class PlayState extends FlxState
{
	private var _player:Player;
	public var player_start:FlxObject;
	
	private var _map:TiledLevel;
	private var _mWalls:FlxTilemap;
	
	private var _timer:Float = 0;
	private var _txtTimer:FlxText;
	
	override public function create():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 3, true);
		
		_player = new Player();
		add(_player);
		
		_map = new TiledLevel(AssetPaths.levelGood__tmx, this);
		add(_map.backgroundLayer);
		add(_map.imagesLayer);
		add(_map.BGObjects);
		add(_map.foregroundObjects);
		add(_map.objectsLayer);
		add(_map.collisionTiles);
		
		_map.foregroundTiles.forEach(function(t:FlxTilemap){t.visible = false; });
		
		var bg:FlxSprite = new FlxSprite().loadGraphic("assets/images/levelBG.png");
		add(bg);
		
		FlxG.camera.follow(_player, FlxCameraFollowStyle.PLATFORMER);
		_player.setPosition(player_start.x, player_start.y);
		
		FlxG.sound.playMusic(AssetPaths.ambience__mp3, 2.4);
		
		
		_txtTimer = new FlxText(20, 20, 0, "", 32);
		_txtTimer.scrollFactor.set();
		_txtTimer.visible = false;
		add(_txtTimer);
		
		super.create();
	}
	override public function update(elapsed:Float):Void
	{
		
		
		super.update(elapsed);
		
		FlxG.collide(_player, _map.foregroundTiles);
		
		if (FlxG.keys.justPressed.R)
		{
			//_player.setPosition(player_start.x, player_start.y);
			_player.reset(player_start.x, player_start.y);
			_timer = 0;
		}
		
		// Time in milliseconds I think
		_timer += FlxG.elapsed * 0.001;
		
		_txtTimer.text = FlxMath.roundDecimal(_timer * 1000, 2) + "s";
		
		if (FlxG.keys.justPressed.T)
		{
			_txtTimer.visible = !_txtTimer.visible;
		}
		
		if (_player.x < 0 - _player.width)
		{
			FlxG.camera.fade(FlxColor.WHITE, 0.5, false, function()
			{
				API.unlockMedal("real gamer");
				API.postScore("Fastest Completion", Std.int(_timer * 1000 * 1000));
				API.postScore("Times beaten", 1);
				EndState.time = FlxMath.roundDecimal(_timer * 1000, 2);
				FlxG.switchState(new EndState()); 
			});
		}
		
		
	}
}