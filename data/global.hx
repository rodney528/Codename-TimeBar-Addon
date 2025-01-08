static var ModOptions = FlxG.save.data;

function new() {
	ModOptions.tbEnable ??= false;
	ModOptions.tbSongName ??= false;
	ModOptions.tbTimeType ??= 'elapsed';
	ModOptions.tbShowEndTime ??= true;
	ModOptions.tbTimeMS ??= false;
}