letters = [];

enum STATES	{
	FREE,
	PICK_UP,
	SWAPPING
}

state = STATES.FREE;
carried_letter = pointer_null;
carried_button = pointer_null;

function add_letter(_letter_data, _letter_name) {
	array_push(letters, create_letter(_letter_data[$ _letter_name]))
}

function sort_letters() {
	for (var _i = 0; _i < array_length(letters); _i++) {
		with (letters[_i]) {
			depth = _i * 2 + 1;
			for (var _j = 0; _j < array_length(buttons); _j++) {
				buttons[_j].depth = _i * 2;
			}
		}
	}
}

week = 0;

global.game = self;

var _letter_data = get_letter_data(1);

add_letter(_letter_data, "test_1")
add_letter(_letter_data, "test_2")
add_letter(_letter_data, "test_3")

sort_letters();

//global.cabinet.get_mail()

function game_state_free() {
	if (mouse_check_button_pressed(mb_left)) {
		var _target = get_mouse_target();
		
		var _letter = _target[0];
		var _letter_i = _target[1];
		var _button = _target[2];
		var _button_i = _target[3];
		
		if (_letter) {
			carried_letter = _letter;
			if (!_button) {
				state = STATES.PICK_UP;
				letters = array_move_to_front(letters, _letter_i);
				sort_letters();
			} else {
				state = STATES.SWAPPING;
				carried_button = _button;
				show_debug_message(carried_button.field_value)
			}
		}
	}
}

function game_state_pick_up() {
	carried_letter.set_paper_position();
	
	if (!mouse_check_button(mb_left)) {
		state = STATES.FREE;
		carried_letter = pointer_null;
	}
}

function game_state_swapping() {
	if (!mouse_check_button(mb_left)) {
		var _target = get_mouse_target();
		
		var _letter = _target[0];
		var _letter_i = _target[1];
		var _button = _target[2];
		var _button_i = _target[3];
		
		if (_button) {
			if (_button.field_type == carried_button.field_type) {
				var _target_val_buffer = _button.field_value;
				var _carried_val_buffer = carried_button.field_value
				
				_button.set_field_value(_carried_val_buffer);
				_letter.swap_field(_button.index, _carried_val_buffer);
				
				carried_button.set_field_value(_target_val_buffer);
				carried_letter.swap_field(carried_button.index, _target_val_buffer);
				
				_letter.update_output_text();
				carried_letter.update_output_text();
			}
		}
		
		state = STATES.FREE;
		carried_letter = pointer_null;
		carried_button = pointer_null;
	}
}

function array_move_to_front(_arr, _index) {
	if (_index < 0 || _index >= array_length(_arr)) {
		show_debug_message("array_move_to_front: Index out of bounds");
		return _arr;
	}
	
	if (_index == 0) {
		return _arr;
	}
	
	var _element_to_move = _arr[_index];
	
	for (var _i = _index; _i > 0; _i--) {
		_arr[_i] = _arr[_i - 1];
	}
	
	_arr[0] = _element_to_move;
	
	return _arr;
}

function get_mouse_target() {
	var _letter = pointer_null;
	var _letter_i = -1;
	var _button = pointer_null;
	var _button_i = -1;
	for (var _i = 0; _i < array_length(letters); _i ++) {
		if (instance_position(mouse_x, mouse_y, letters[_i])) {
			_letter = letters[_i]
			_letter_i = _i;
			break;
		}
	}
	if (_letter) {
		for (var _i = 0; _i < array_length(_letter.buttons); _i ++) {
			if (instance_position(mouse_x, mouse_y, _letter.buttons[_i])) {
				_button = _letter.buttons[_i];
				_button_i = _i;
				break;
			}
		}
	}
	return [_letter, _letter_i, _button, _button_i];
}

state_map = {}
state_map[$ STATES.FREE] = game_state_free;
state_map[$ STATES.PICK_UP] = game_state_pick_up;
state_map[$ STATES.SWAPPING] = game_state_swapping;