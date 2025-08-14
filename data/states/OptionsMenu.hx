import funkin.options.TreeMenuScreen;
import funkin.options.type.ArrayOption;
import funkin.options.type.Checkbox;
import funkin.options.type.TextOption;

function postCreate():Void {
	var title:String = 'Time Bar Options';
	var desc:String = 'Settings for Rodney\'s TimeBar Addon!';
	tree[0].add(new TextOption(title, desc, ' >', () -> {
		var options = [
			new Checkbox(
				'Enable TimeBar', 'Do you wish to enable the timebar?',
				'enable', null, TimeBarOptions
			),
			new Checkbox(
				'Show Song Name', 'Should the timebar text show the song display name?',
				'songName', null, TimeBarOptions
			),
			new ArrayOption(
				'Time Type', 'How should it show the time?',
				['elapsed', 'remainder', 'nothing', 'both'], ['Elapsed', 'Remaining', 'Don\'t Show', 'How about Both?'],
				'timeType', null, TimeBarOptions
			),
			new Checkbox(
				'Show End Time', 'Should the timebar text show the end time?',
				'showEndTime', null, TimeBarOptions
			),
			new Checkbox(
				'Show Milliseconds', 'Should the timebar text show milliseconds?\nNote: This won\'t show on end time if the song has a perfect length.',
				'timeMS', null, TimeBarOptions
			)
		];
		function refreshLocks():Void {
			for (i => option in options)
				if (i != 0)
					option.locked = !options[0].checked;
		}
		options[0].selectCallback = refreshLocks;
		refreshLocks();
		addMenu(new TreeMenuScreen(title, desc, ' >', options));
	}));
}