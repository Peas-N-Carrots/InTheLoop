function reset_fields() {
	global.game.state = STATES.CLEANUP;
	
	for (var _i = 0; _i < array_length(global.game.letters); _i++) {
		global.game.letters[_i].speed_y = -power(1.1, _i*10);
	}
}

action_script = reset_fields;