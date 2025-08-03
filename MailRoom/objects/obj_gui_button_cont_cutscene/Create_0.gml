function continue_cutscene() {
	var _co = global.game.cutscene_obj;
	if (instance_exists(_co)) {
		if (_co.progress < string_length(_co.text_value)) {
			_co.progress = string_length(_co.text_value);
		} else {
			with (global.game) {
				var _letter_data = get_letter_data(week, path);
				add_letters(_letter_data);
				sort_letters();
				
				state = STATES.SETUP;
				
				instance_destroy(_co);
				var _mo = mail_obj;
				if (instance_exists(_mo)) instance_destroy(_mo);
				letter_icons = [];
			}
		}
	}
	
	for (var _i = 0; _i < array_length(global.game.letters); _i++) {
		global.game.letters[_i].speed_y = -power(1.1, _i*10);
	}
}

function is_cutscene() {
	switch (global.game.state) {
		case STATES.CUTSCENE:
			return true;
		default:
			return false;
	}
}

action_script = continue_cutscene;
active_script = is_cutscene;