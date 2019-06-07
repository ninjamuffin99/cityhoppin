package;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.addons.util.PNGEncoder;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.system.replay.FlxReplay;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import openfl.display.BitmapData;
import openfl.utils.ByteArray;
import openfl.utils.Object;

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
	
	private static var recording:Bool = false;
	private static var replaying:Bool = false;
	
	private var endStuff:FlxGroup;
	private var flashAd:FlashAd;
	
	override public function create():Void
	{
		
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
		
		
		
		
		if (Main.fisrtRun)
		{
			FlxG.camera.fade(FlxColor.BLACK, 3, true, function(){Main.fisrtRun = false;});
			
			API.addEventListener(APIEvent.FILE_SAVED, function(e:APIEvent)
			{
				if (e.success)
				{
					FlxG.log.add("saving was successful!");
					FlxG.log.add(e.data);
				}
				else
					FlxG.log.error("Error creating save: " + e.error);
			});
			
			API.addEventListener(APIEvent.FILE_REQUESTED, function(e:APIEvent)
			{
				if (e.success)
				{
					FlxG.log.add("file requesting was successful!");
					FlxG.log.add(e.data);
				}
				else
					FlxG.log.error("error loading file: " + e.error);
			});
			
			API.addEventListener(APIEvent.FILE_LOADED, function(e:APIEvent)
			{
				if (e.success)
				{
					FlxG.log.add("file loading was successful!");
					// loadReplay(e.data.data);
					
					EndState.time = FlxMath.roundDecimal(_timer * 1000, 2);
		
					replaying = true;
					recording = false;
					
					FlxG.vcr.stopRecording(false);
					
					var save = e.data.data.theReplay;
					
					FlxG.vcr.loadReplay(save, new PlayState(), ["ENTER"], 0, startRecording);
								
					FlxG.log.add(e.data);
				}
				else
					FlxG.log.error("error requesting file: " + e.error);
			});
			
			
		}

		if (replaying)
		{
			persistentDraw = persistentUpdate = true;
			openSubState(new EndState());
		}
		else
		{
			
			// endStuff.visible = false;
		}
		
		super.create();
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (!recording && !replaying)
		{
			startRecording();
		}
		
		FlxG.collide(_player, _map.foregroundTiles);
		
		if (FlxG.keys.justPressed.R && recording)
		{
			FlxG.vcr.stopRecording(false);
			startRecording();
		}
		
		if (FlxG.keys.justPressed.F && recording)
		{
			loadReplay();
		}
		
		
		// Time in milliseconds I think
		_timer += FlxG.elapsed * 0.001;
		
		_txtTimer.text = FlxMath.roundDecimal(_timer * 1000, 2) + "s";
		
		
		if (replaying)
		{
			_txtTimer.visible = true;
			
			if (FlxG.keys.pressed.SHIFT)
			{
				_txtTimer.visible = false;
			}
			
		}
		
		
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
				
				
				loadReplay();
				// FlxG.switchState(new EndState()); 
			});
		}
	}
	
	private function startRecording():Void
	{
		recording = true;
		replaying = false;
		
		FlxG.vcr.startRecording(false);
	}
	
	private function loadReplay(dataOverride:String = ""):Void
	{
		EndState.time = FlxMath.roundDecimal(_timer * 1000, 2);
		
		replaying = true;
		recording = false;
		
		var save = FlxG.vcr.stopRecording(false);
		
		
		if (dataOverride.length > 0)
		{
			save = dataOverride;
		}
		else
		{
			var saveFile = API.createSaveFile("Replays");
			saveFile.data = {theReplay: save};
			saveFile.name = "Test " + FlxG.random.int(0, 100);
			saveFile.icon = _player.pixels;
			saveFile.description = "seconds";
			saveFile.save();
			
		}
		
		FlxG.vcr.loadReplay(save, new PlayState(), ["ENTER"], 0, startRecording);
	}
}