function add_letter(_letter_settings){
	var _new_letter = instance_create_layer(0, 0, "Instances", obj_letter);
	_new_letter.letter_text = _letter_settings.letter_text
	_new_letter.fields = _letter_settings.fields
	return _new_letter;
}

function setup_weekly_letters(){
	var _letters = []
	
	var _letter_data = get_letter_data(1);
	var _letters_to_add = [];
	
	if (true) {
		array_push(_letters_to_add, _letter_data.test_letter_1);
	}
	
	for (var _i = 0; _i < array_length(_letters_to_add); _i++) {
		array_push(_letters, add_letter(_letters_to_add[_i]));
	}
	
	return _letters
}