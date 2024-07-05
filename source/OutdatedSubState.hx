package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;

class OutdatedSubState extends MusicBeatState
{
	public static var leftState:Bool = false;

	override function create()
	{
		function text():String
		{
			#if !hl
			var ver = "v" + Application.current.meta.get('version');
			var version = #if windows "Windows" #elseif mac 'Mac' #elseif linux "Linux" #elseif mobile "Mobile" #elseif web "Web" #end;
			var debugThing = #if debug "to go to The Github Build" #else 'to download the latest version on Itch' #end;
			return "YO! You're running a " 
			+ version
			+ " outdated version of the engine!\nCurrent version is "
			+ ver
			+ " while the most recent version is "
			+ NGio.GAME_VER
			+ "! Press Space "
			+ debugThing
			+ ', or ESCAPE to ignore this!!';
			#else
			return "Uhm... So you're using hl to debug, bitch. Why do you want a version?";
			#end
		}
		super.create();
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);
		var ver = "v" + Application.current.meta.get('version');
		var txt:FlxText = new FlxText(0, 0, FlxG.width,text(),
			32);
		txt.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		txt.screenCenter();
		add(txt);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			#if linux
			Sys.command('xdg-open', ["https://ninja-muffin24.itch.io/funkin"]);
			#else
			FlxG.openURL('https://ninja-muffin24.itch.io/funkin');
			#end
		}
		if (controls.BACK)
		{
			leftState = true;
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
}
