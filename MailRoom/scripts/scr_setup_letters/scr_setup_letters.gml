function create_letter(_letter_settings){
	var _new_letter = instance_create_layer(0, 0, "Instances", obj_letter);
	_new_letter.letter_text = _letter_settings.letter_text
	_new_letter.fields = _letter_settings.fields
	_new_letter.update_output_text();
	return _new_letter;
}

function recieve_letters(_week, _input_letters){
	var _letters = []
	
	var _letter_data = get_letter_data(_week);
	var _letter_names = struct_get_names(_letter_data)
	
	for (var _i = 0; _i < array_length(_letter_names); _i++) {
		var _letter = _letter_data[$ _letter_names[_i]];
		
		if (!_letter.previous || array_contains(_input_letters, _letter.previous)) {
			array_push(_letters, create_letter(_letter)); // idk if this is how it works
		}
	}
	
	return _letters
}

function check_criteria() {
	
}