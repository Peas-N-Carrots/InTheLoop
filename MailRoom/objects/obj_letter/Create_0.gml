#macro FONT_TRACKING 7
#macro FONT_LEADING 12

#macro BUTTON_OPACITY (0.15 + 0.03 * sin(current_time * .001 * pi * 2))

function swap_field(_index, _val) {
	fields[_index][1] = _val
}

function update_output_text() {
	output_text = plug_in_text(letter_text, fields);
	
	for (var _i = 0; _i < array_length(buttons); _i++) {
		with (buttons[_i]) {
			instance_destroy();
		}
	}
	
	var _val = split_text(x, y, output_text, 34);
	line_starts = _val[0];
	buttons = _val[1];
}

function plug_in_text(_input_string, _fields) {
	var _output = _input_string;

	for (var _i = 0; _i < array_length(_fields); _i++) {
		var _token = "~" + string(_i) + "~";
		var _value = "~" + string(_i) + _fields[_i][1] + "~" + string(_i);
		_output = string_replace_all(_output, _token, _value);
	}
	
	return _output;
}

function split_text(_start_x, _start_y, _text, _len) {
	var _x = _start_x;
	var _y = _start_y;
	var _line_starts = [0];
	var _button = false;
	var _button_this_word = false;
	var _buttons = []
	
	var _next_button = pointer_null;
	
	var _space_i = 0;
	
	for (var _i = 1; _i <= string_length(_text); _i ++) {
		var _char = string_copy(_text, _i, 1);
		
		var _zero_width = "~";
		if (_char == _zero_width) {
			var _button_number = string_copy(_text, _i+1, 1);
			
			_text = string_copy(_text, 1, _i - 1) + string_copy(_text, _i + 2, string_length(_text) - _i - 1);
			_button = !_button;
			
			if (_button) {
				_next_button = instance_create_layer(_x, _y, "Instances", obj_button);
				
				var _field = fields[_button_number];
				_next_button.field_type = _field[0];
				_next_button.field_value = _field[1];
				_next_button.index = _button_number;
				
				_next_button.image_xscale = 0;
				
				array_push(_buttons, _next_button);
				_button_this_word = true;
			}
			_i --;
		} else {
			if (_char == " " && !_button){
				_space_i = _i;
				_button_this_word = false;
				_next_button = pointer_null;
			} else if (_char == "\n" || _i - _line_starts[array_length(_line_starts) - 1] >= _len) {
				if (_char == "\n") {
					_space_i = _i;
					_button_this_word = false;
					_next_button = pointer_null;
				}
				
				array_push(_line_starts, _space_i + 1)
				_y += FONT_LEADING;
				_x = _start_x;
				_x += FONT_TRACKING * (_i - _line_starts[array_length(_line_starts) - 1])
				
				if (_next_button) {
					_next_button.x = _start_x
					_next_button.y = _y
				}
			}
			_x += FONT_TRACKING;
			if (_button && _next_button) {
				_next_button.image_xscale ++;
			}
		}
	}
	
	return [_line_starts, _buttons];
}

function draw_letter_text(_start_x, _start_y, _text, _line_starts) {
	draw_set_font(fnt_letter);
	
	var _x = _start_x;
	var _y = _start_y;
	var _line = 1;
	
	var _button = false
	var _button_id = 0
	
	for (var _i = 1; _i <= string_length(_text); _i ++) {
		var _char = string_copy(_text, _i, 1);
		
		var _zero_width = "~";
		if (_char != _zero_width) {
			if (_line < array_length(_line_starts) && _i == _line_starts[_line]) {
				_y += FONT_LEADING;
				_x = _start_x;
				_line ++;
			}
			
			if !(_button && global.game.carried_button == buttons[_button_id]) {
				if (_button) draw_set_color(global.colors[$ fields[_button_id][0]]) else draw_set_color(c_black);
				draw_text(_x, _y, _char);
				draw_set_color(c_white);
			}
			
			_x += FONT_TRACKING;
		} else {
			_button_id = string_copy(_text, _i + 1, 1);
			_text = string_copy(_text, 1, _i - 1) + string_copy(_text, _i + 2, string_length(_text) - _i - 1);
			_button = !_button;
			_i --;
		}
	}
}

function set_paper_position(_x = x + mouse_x - prev_mouse_x, _y = y + mouse_y - prev_mouse_y) {
	var _delta_x = _x - x;
	var _delta_y = _y - y;
	
	x += _delta_x
	y += _delta_y
	
	for (var _i = 0; _i < array_length(buttons); _i++) {
		with (buttons[_i]) {
			x += _delta_x
			y += _delta_y
		}
	}
}

function touching_mouse(_x, _y, _sep_x, _sep_y) {
	
}

output_text = "";
line_starts = [];
buttons = [];

update_output_text();

carried = false;

prev_mouse_x = 0;
prev_mouse_y = 0;

speed_x = 0;
speed_y = 0;