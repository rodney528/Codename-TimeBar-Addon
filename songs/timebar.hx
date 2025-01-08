import flixel.ui.FlxBar;
import flixel.ui.FlxBarFillDirection;
import flixel.util.FlxStringUtil;

public var timeBarBG:FlxSprite;
public var timeBar:FlxBar;
public var timeText:FunkinText;

public var hideTime:Bool = false;

function postCreate():Void {
	timeBarBG = CoolUtil.loadAnimatedGraphic(new FlxSprite(0, FlxG.height * 0.02), Paths.image('game/timeBar'));
	timeBarBG.screenCenter(FlxAxes.X);
	add(timeBarBG);

	timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBarFillDirection.LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), inst, 'time', 0, inst.length);
	timeBar.createFilledBar(0xff363636, SONG.meta.parsedColor ?? FlxColor.fromString(SONG.meta.color ?? '#C0C0C0'));
	timeBar.numDivisions = timeBar.width;
	add(timeBar);

	timeText = new FunkinText(timeBarBG.x, timeBarBG.y, Std.int(timeBarBG.width), formatTime(inst.time / 1000), 16);
	timeText.alignment = 'center';
	add(timeText);

	for (e in [timeBarBG, timeBar, timeText]) {
		if (!ModOptions.tbEnable) {
			e.visible = false;
			e.alpha = 0;
		}
		e.cameras = [camHUD];
	}
}

function hideNumbers(text:String):Void {
	var result:String = text;
	if (hideTime)
		for (i in 0...10)
			result = StringTools.replace(result, i, '#');
	return result;
}

function formatTime(time:Float):String {
	var elapsed:String = FlxStringUtil.formatTime(time, ModOptions.tbTimeMS);
	var remainder:String = FlxStringUtil.formatTime(inst.length / 1000 - time, ModOptions.tbTimeMS);
	var result:String = hideNumbers(switch (ModOptions.tbTimeType) {
		case 'elapsed': elapsed;
		case 'remainder': remainder;
		case 'both': remainder + ' ~ ' + elapsed;
		case 'nothing': '';
	});
	var end:String = (ModOptions.tbTimeType == 'nothing' ? '' : ' / ') + hideNumbers(StringTools.replace(FlxStringUtil.formatTime(inst.length / 1000, ModOptions.tbTimeMS), '.00', ''));
	return (ModOptions.tbSongName ? (SONG.meta.displayName + ' / ') : '') + result + (ModOptions.tbShowEndTime ? end : '');
}

function postUpdate(elapsed:Float):Void
	if (ModOptions.tbEnable && inst.playing)
		timeText.text = formatTime(inst.time / 1000);