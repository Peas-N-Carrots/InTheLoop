function reset_fields() {
	var _letters = global.game.letters;
	for (var _i = 0; _i < array_length(_letters); _i++) {
		var _letter = _letters[_i]
		var _buttons = _letter.buttons;
		
		for (var _j = 0; _j < array_length(_buttons); _j++) {
			var _button = _buttons[_j];
			_button.field_value = _letter.fields_defaults[_button.index];
		}
		
		for (var _j = 0; _j < array_length(_letter.fields); _j++) {
			_letter.swap_field(_j, _letter.fields_defaults[_j]);
		}
		
		_letter.update_output_text();
	}
	
	global.game.sort_letters();
	
	global.game.swapped = false;
}

function reset_active() {
	return global.game.swapped;
}

action_script = reset_fields;
condition_script = reset_active;