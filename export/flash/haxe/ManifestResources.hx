package;


import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#elseif (winrt)
			rootPath = "./";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end

		}

		Assets.defaultRootPath = rootPath;

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:sizezy4:typey4:TEXTy9:classNamey39:__ASSET__assets_data_data_goes_here_txty2:idy34:assets%2Fdata%2Fdata-goes-here.txtgoR0i2561R1R2R3y29:__ASSET__assets_data_gmtk_oepR5y24:assets%2Fdata%2Fgmtk.oepgoR0i11684R1R2R3y31:__ASSET__assets_data_level1_oelR5y26:assets%2Fdata%2Flevel1.oelgoR0i8168779R1y6:BINARYR3y32:__ASSET__assets_data_levelbg_kraR5y27:assets%2Fdata%2FlevelBG.kragoR0i8163887R1R11R3y33:__ASSET__assets_data_levelbg_kra_R5y30:assets%2Fdata%2FlevelBG.kra%7EgoR0i316428R1y5:IMAGER3y35:__ASSET__assets_data_levelbgpng_pngR5y30:assets%2Fdata%2FlevelBGpng.pnggoR0i316428R1R11R3y36:__ASSET__assets_data_levelbgpng_png_R5y33:assets%2Fdata%2FlevelBGpng.png%7EgoR0i47236R1R16R3y34:__ASSET__assets_data_levelgood_pngR5y29:assets%2Fdata%2FlevelGood.pnggoR0i53513R1R2R3y34:__ASSET__assets_data_levelgood_tmxR5y29:assets%2Fdata%2FlevelGood.tmxgoR0i196R1R16R3y32:__ASSET__assets_data_tileset_pngR5y27:assets%2Fdata%2Ftileset.pnggoR0zR1R2R3y41:__ASSET__assets_images_images_go_here_txtR5y36:assets%2Fimages%2Fimages-go-here.txtgoR0i2274768R1R16R3y34:__ASSET__assets_images_levelbg_pngR5y29:assets%2Fimages%2FlevelBG.pnggoR0i976156R1R11R3y35:__ASSET__assets_images_levelbg_png_R5y32:assets%2Fimages%2FlevelBG.png%7EgoR0i1793754R1R11R3y36:__ASSET__assets_images_mapsketch_kraR5y31:assets%2Fimages%2FmapSketch.kragoR0i1793754R1R11R3y37:__ASSET__assets_images_mapsketch_kra_R5y34:assets%2Fimages%2FmapSketch.kra%7EgoR0i4754R1R16R3y33:__ASSET__assets_images_player_pngR5y28:assets%2Fimages%2Fplayer.pnggoR0i4375R1R11R3y34:__ASSET__assets_images_player_png_R5y31:assets%2Fimages%2Fplayer.png%7EgoR0i1683R1R11R3y48:__ASSET__assets_images_playerspritefile_asepriteR5y43:assets%2Fimages%2FplayerSpriteFile.asepritegoR0i24161R1R16R3y36:__ASSET__assets_images_thumbnail_pngR5y31:assets%2Fimages%2Fthumbnail.PNGgoR0zR1R2R3y41:__ASSET__assets_music_music_goes_here_txtR5y36:assets%2Fmusic%2Fmusic-goes-here.txtgoR0i4414477R1y5:MUSICR3y35:__ASSET__assets_sounds_ambience_mp3R5y30:assets%2Fsounds%2Fambience.mp3goR0i43624R1y5:SOUNDR3y32:__ASSET__assets_sounds_boost_wavR5y27:assets%2Fsounds%2Fboost.wavgoR0i36884R1R50R3y36:__ASSET__assets_sounds_hitground_wavR5y31:assets%2Fsounds%2FhitGround.wavgoR0i27542R1R50R3y35:__ASSET__assets_sounds_jumpbase_wavR5y30:assets%2Fsounds%2FjumpBase.wavgoR0i72266R1R50R3y35:__ASSET__assets_sounds_sidejump_wavR5y30:assets%2Fsounds%2FsideJump.wavgoR0zR1R2R3y41:__ASSET__assets_sounds_sounds_go_here_txtR5y36:assets%2Fsounds%2Fsounds-go-here.txtgoR0i2114R1R47R3y31:__ASSET__flixel_sounds_beep_mp3R5y26:flixel%2Fsounds%2Fbeep.mp3goR0i39706R1R47R3y33:__ASSET__flixel_sounds_flixel_mp3R5y28:flixel%2Fsounds%2Fflixel.mp3goR0i15744R1y4:FONTR3y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfgoR0i29724R1R65R3y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfgoR0i519R1R16R3y36:__ASSET__flixel_images_ui_button_pngR5y33:flixel%2Fimages%2Fui%2Fbutton.pnggoR0i3280R1R16R3y39:__ASSET__flixel_images_logo_default_pngR5y36:flixel%2Fimages%2Flogo%2Fdefault.pnggh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_gmtk_oep extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_level1_oel extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_levelbg_kra extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_levelbg_kra_ extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_levelbgpng_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_levelbgpng_png_ extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_levelgood_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_levelgood_tmx extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_tileset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_levelbg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_levelbg_png_ extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mapsketch_kra extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mapsketch_kra_ extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_player_png_ extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_playerspritefile_aseprite extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_thumbnail_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_ambience_mp3 extends flash.media.Sound { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_boost_wav extends flash.media.Sound { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_hitground_wav extends flash.media.Sound { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_jumpbase_wav extends flash.media.Sound { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sidejump_wav extends flash.media.Sound { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends flash.media.Sound { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends flash.text.Font { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends flash.text.Font { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends flash.utils.ByteArray { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/gmtk.oep") @:noCompletion #if display private #end class __ASSET__assets_data_gmtk_oep extends haxe.io.Bytes {}
@:keep @:file("assets/data/level1.oel") @:noCompletion #if display private #end class __ASSET__assets_data_level1_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/levelBG.kra") @:noCompletion #if display private #end class __ASSET__assets_data_levelbg_kra extends haxe.io.Bytes {}
@:keep @:file("assets/data/levelBG.kra~") @:noCompletion #if display private #end class __ASSET__assets_data_levelbg_kra_ extends haxe.io.Bytes {}
@:keep @:image("assets/data/levelBGpng.png") @:noCompletion #if display private #end class __ASSET__assets_data_levelbgpng_png extends lime.graphics.Image {}
@:keep @:file("assets/data/levelBGpng.png~") @:noCompletion #if display private #end class __ASSET__assets_data_levelbgpng_png_ extends haxe.io.Bytes {}
@:keep @:image("assets/data/levelGood.png") @:noCompletion #if display private #end class __ASSET__assets_data_levelgood_png extends lime.graphics.Image {}
@:keep @:file("assets/data/levelGood.tmx") @:noCompletion #if display private #end class __ASSET__assets_data_levelgood_tmx extends haxe.io.Bytes {}
@:keep @:image("assets/data/tileset.png") @:noCompletion #if display private #end class __ASSET__assets_data_tileset_png extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/levelBG.png") @:noCompletion #if display private #end class __ASSET__assets_images_levelbg_png extends lime.graphics.Image {}
@:keep @:file("assets/images/levelBG.png~") @:noCompletion #if display private #end class __ASSET__assets_images_levelbg_png_ extends haxe.io.Bytes {}
@:keep @:file("assets/images/mapSketch.kra") @:noCompletion #if display private #end class __ASSET__assets_images_mapsketch_kra extends haxe.io.Bytes {}
@:keep @:file("assets/images/mapSketch.kra~") @:noCompletion #if display private #end class __ASSET__assets_images_mapsketch_kra_ extends haxe.io.Bytes {}
@:keep @:image("assets/images/player.png") @:noCompletion #if display private #end class __ASSET__assets_images_player_png extends lime.graphics.Image {}
@:keep @:file("assets/images/player.png~") @:noCompletion #if display private #end class __ASSET__assets_images_player_png_ extends haxe.io.Bytes {}
@:keep @:file("assets/images/playerSpriteFile.aseprite") @:noCompletion #if display private #end class __ASSET__assets_images_playerspritefile_aseprite extends haxe.io.Bytes {}
@:keep @:image("assets/images/thumbnail.PNG") @:noCompletion #if display private #end class __ASSET__assets_images_thumbnail_png extends lime.graphics.Image {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/ambience.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_ambience_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/boost.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_boost_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/hitGround.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_hitground_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/jumpBase.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_jumpbase_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sideJump.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_sidejump_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,6,1/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,6,1/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:font("C:/HaxeToolkit/haxe/lib/flixel/4,6,1/assets/fonts/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("C:/HaxeToolkit/haxe/lib/flixel/4,6,1/assets/fonts/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,6,1/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,6,1/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
