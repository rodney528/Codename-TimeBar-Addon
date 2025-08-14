static var TimeBarOptions = FlxG.save.data.RODNEY_TIMEBAR;

function new() {
	TimeBarOptions = FlxG.save.data.RODNEY_TIMEBAR ??= {
		enable: true,
		songName: false,
		timeType: 'elapsed',
		showEndTime: true,
		timeMS: false
	}
}