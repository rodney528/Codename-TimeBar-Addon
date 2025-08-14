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
	timeBar.createFilledBar(0xff363636, SONG.meta.color ?? 0xFFC0C0C0);
	timeBar.numDivisions = timeBar.width;
	add(timeBar);

	timeText = new FunkinText(timeBarBG.x, timeBarBG.y, Std.int(timeBarBG.width), formatTime(inst.time / 1000), 16);
	timeText.alignment = 'center';
	add(timeText);

	for (e in [timeBarBG, timeBar, timeText]) {
		if (!TimeBarOptions.enable) {
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
	var result:Array<String> = [];

	if (TimeBarOptions.songName)
		result.push(SONG.meta.displayName);

	if (TimeBarOptions.timeType != 'nothing') {
		var elapsed:String = FlxStringUtil.formatTime(time, TimeBarOptions.timeMS);
		var remainder:String = FlxStringUtil.formatTime(inst.length / 1000 - time, TimeBarOptions.timeMS);
		result.push(hideNumbers(switch (TimeBarOptions.timeType) {
			case 'elapsed': elapsed;
			case 'remainder': remainder;
			case 'both': remainder + ' ~ ' + elapsed;
		}));
	}

	if (TimeBarOptions.showEndTime)
		result.push(hideNumbers(StringTools.replace(FlxStringUtil.formatTime(inst.length / 1000, TimeBarOptions.timeMS), '.00', '')));

	return result.join(' / ');
}

function postUpdate(elapsed:Float):Void
	if (TimeBarOptions.enable && inst.playing)
		timeText.text = formatTime(inst.time / 1000);