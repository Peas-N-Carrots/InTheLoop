function reset_fields() {
	global.game.state = STATES.CLEANUP;
	
	for (var _i = 0; _i < array_length(global.game.letters); _i++) {
		global.game.letters[_i].speed_y = -power(1.1, _i*10);
	}
}

function is_not_cutscene() {
	switch (global.game.state) {
		case STATES.FREE: case STATES.PICK_UP: case STATES.SWAPPING:
			return true;
		default:
			return false;
	}
}

action_script = reset_fields;
active_script = is_not_cutscene;