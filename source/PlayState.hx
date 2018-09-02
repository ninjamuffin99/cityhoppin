package;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var _player:Player;
	public var player_start:FlxObject;
	
	private var _map:TiledLevel;
	private var _mWalls:FlxTilemap;
	
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
		
		super.create();
	}
	override public function update(elapsed:Float):Void
	{
		
		
		super.update(elapsed);
		
		FlxG.collide(_player, _map.foregroundTiles);
		
		if (_player.x < 0 - _player.width)
		{
			FlxG.camera.fade(FlxColor.WHITE, 0.5, false, function(){FlxG.switchState(new EndState()); });
		}
		
		
	}
}