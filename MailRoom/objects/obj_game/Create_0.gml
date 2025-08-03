randomize();
letters = [];

global.colors = {}
global.colors[$ FIELD_TYPES.COST] = c_green;
global.colors[$ FIELD_TYPES.DATE] = c_fuchsia;
global.colors[$ FIELD_TYPES.NOUN] = c_blue;
global.colors[$ FIELD_TYPES.NUMBER] = c_orange;
global.colors[$ FIELD_TYPES.VERB] = c_red;

global.names = {}
global.names[$ NAMES.EXECUTIVE] = " # Executive Dept #";
global.names[$ NAMES.MARKETING] = " @ Marketing Dept @"
global.names[$ NAMES.JETSTREAM] = " ^ Jetstream Orders ^"
global.names[$ NAMES.FINANCIAL] = " & Financial Dept &"
global.names[$ NAMES.LEGAL] = " } Legal Dept }"
global.names[$ NAMES.TIMES] = " { The Daily Times {"

enum STATES	{
	FREE,
	PICK_UP,
	SWAPPING,
	SETUP,
	CLEANUP,
	CUTSCENE
}

state = STATES.SETUP;
carried_letter = pointer_null;
carried_button = pointer_null;
swapped = false;
cutscene_obj = noone;
mail_obj = noone;

function create_letter(_letter_settings){
	var _new_letter = instance_create_layer(0, 0, "Instances", obj_letter);
	
	with (_new_letter) {
		letter_text = _letter_settings.letter_text;
		fields = _letter_settings.fields;
		title = _letter_settings.title;
		addresses = _letter_settings.addresses;
		fields_defaults = [];
		for(var _i = 0; _i < array_length(fields); _i++) {
			array_push(fields_defaults, fields[_i][1]);
		}
		update_output_text();
	}
	return _new_letter;
}

function add_letters(_letter_data) {
	for (var _i = 0; _i < array_length(_letter_data); _i++) {
		var _letter = create_letter(_letter_data[_i]);
		_letter.set_paper_position(-240, irandom_range(20, 40));
		var _speed = 60 * power(0.8, array_length(letters));
		var _dir = random_range(-2, 2);
		_letter.speed_x = lengthdir_x(_speed, _dir);
		_letter.speed_y = lengthdir_y(_speed, _dir);
		array_push(letters, _letter);
	}
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

function destroy_letters() {
	for (var _i = 0; _i < array_length(letters); _i++) {
		with (letters[_i]) {
			for (var _j = 0; _j < array_length(buttons); _j++) {
				instance_destroy(buttons[_j]);
			}
			instance_destroy();
		}
	}
	letters = [];
}

week = 1;
path = "";

global.game = self;

var _letter_data = get_letter_data(1, path);

add_letters(_letter_data);

sort_letters();

function game_state_free() {
	if (mouse_check_button_pressed(mb_left) && !position_meeting(mouse_x, mouse_y, obj_gui_button)) {
		var _target = get_mouse_target();
		
		var _letter = _target[0];
		var _letter_i = _target[1];
		var _button = _target[2];
		var _button_i = _target[3];
		
		if (_letter) {
			carried_letter = _letter;
			if (!_button || swapped) {
				state = STATES.PICK_UP;
				with (carried_letter) {
					carried = true;
					set_paper_position(x - 4, y - 4);
				}
				letters = array_move_to_front(letters, _letter_i);
				sort_letters();
			} else {
				state = STATES.SWAPPING;
				carried_button = _button;
				carried_button.carried = true;
				
				carried_button_offset_x = carried_button.x - mouse_x;
				carried_button_offset_y = carried_button.y - mouse_y;
			}
		}
	}
}

function game_state_pick_up() {
	carried_letter.set_paper_position();
	
	if (!mouse_check_button(mb_left)) {
		state = STATES.FREE;
		carried_letter.carried = false;
		with (carried_letter) {
			set_paper_position(x + 4, y + 4);
		}
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
		
		carried_button.carried = false;
		
		if (_button) {
			if (_button != carried_button && _button.field_type == carried_button.field_type) {
				var _target_val_buffer = _button.field_value;
				var _carried_val_buffer = carried_button.field_value
				
				_button.field_value = _carried_val_buffer;
				_letter.swap_field(_button.index, _carried_val_buffer);
				
				carried_button.field_value = _target_val_buffer;
				carried_letter.swap_field(carried_button.index, _target_val_buffer);
				
				_letter.update_output_text();
				carried_letter.update_output_text();
				
				sort_letters();
				
				swapped = true;
			}
		}
		
		state = STATES.FREE;
		carried_letter = pointer_null;
		carried_button = pointer_null;
	}
}

function game_state_setup() {
	var _all_slow = true;
	for (var _i = 0; _i < array_length(letters); _i++) {
		if (point_distance(0, 0, letters[_i].speed_x, letters[_i].speed_y) > 1) {
			_all_slow = false;
		}
	}
	if (_all_slow) {
		state = STATES.FREE;
	}
}

function game_state_cleanup() {
	var _all_above = true;
	
	for (var _i = 0; _i < array_length(letters); _i++) {
		if (letters[_i].y > -300) {
			_all_above = false;
		}
	}
	
	if (_all_above) {
		path = get_path(week, letters);
		
		letter_icons = [];
		for (var _i = 0; _i < array_length(letters); _i ++) {
			var _addresses = letters[_i].addresses;
			array_push(letter_icons, _addresses);
		}
		destroy_letters();
		
		if (instance_exists(cutscene_obj)) instance_destroy(cutscene_obj);
		cutscene_obj = instance_create_layer(32, 32, "Instances", obj_cutscene_text);
		cutscene_obj.text_value = get_cutscene(week, path);
		
		week ++;
		
		state = STATES.CUTSCENE;
		/*var _letter_data = get_letter_data(week, path);
		add_letters(_letter_data);
		sort_letters();*/
	} 
}

function game_state_cutscene() {
	if (instance_exists(cutscene_obj) && cutscene_obj.progress > string_length(cutscene_obj.text_value) + 60) {
		//if (instance_exists(cutscene_obj)) instance_destroy(cutscene_obj);
	}
	if (!instance_exists(mail_obj)) {
		if (array_length(letter_icons) > 0) mail_obj = create_mail_between(array_pop(letter_icons));
	}
}

function create_mail_between(_addresses) {
	var _id_0 = pointer_null;
	var _id_1 = pointer_null;
	with (obj_cutscene_point) {
		if (_addresses[0] == point_id) _id_0 = self
		if (_addresses[1] == point_id) _id_1 = self
	}
	if (!_id_0 || !_id_1) {
		return noone;
	}
	return create_mail_icon(_id_0, obj_cutscene_central_point, _id_1);
}

function create_mail_icon(_start_obj, _midd_obj, _end_obj) {
	var _return = instance_create_layer(0, 0, "GUI_OBJECTS", obj_mail_icon);
	
	_return.x_1 = _start_obj.x;
	_return.y_1 = _start_obj.y;
	
	_return.x_2 = _midd_obj.x;
	_return.y_2 = _midd_obj.y;
	
	_return.x_3 = _end_obj.x;
	_return.y_3 = _end_obj.y;
	
	_return.x = _return.x_1;
	_return.y = _return.y_1;
	
	_return.depth = -100;
	
	return _return;
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
			if (position_meeting(mouse_x, mouse_y, _letter.buttons[_i])) {
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
state_map[$ STATES.SETUP] = game_state_setup;
state_map[$ STATES.CLEANUP] = game_state_cleanup;
state_map[$ STATES.CUTSCENE] = game_state_cutscene;

countdown = 0;

display_set_gui_size(640, 360);

carried_button_offset_x = 0;
carried_button_offset_y = 0;

function draw_carried_button(_button, _x, _y) {
	var _color = global.colors[$ _button.field_type];
	
	draw_sprite_ext(spr_button, 0, _x, _y, _button.image_xscale, 1, 0, c_white, 1);
	draw_sprite_ext(spr_button, 0, _x, _y, _button.image_xscale, 1, 0, _color, BUTTON_OPACITY);
	
	draw_button_text(_button.field_value, _x, _y, _color);
}

function draw_button_text(_text, _start_x, _start_y, _color) {
	draw_set_font(fnt_letter);
	
	var _x = _start_x;
	var _y = _start_y;
	
	draw_set_color(_color);
	for (var _i = 1; _i <= string_length(_text); _i++) {
		draw_text(_x, _y, string_copy(_text, _i, 1));
		_x += FONT_TRACKING;
	}
	draw_set_color(c_white);
}