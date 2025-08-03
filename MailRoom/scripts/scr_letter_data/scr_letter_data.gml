enum FIELD_TYPES {
	DATE,
	NUMBER,
	COST,
	NOUN,
	VERB
}

enum NAMES {
	EXECUTIVE,
	MARKETING,
	JETSTREAM,
	FINANCIAL,
	LEGAL,
	TIMES,
	REVIEWERS
}

function get_letter_data(_week, _path){
	var _return = pointer_null;
	switch (_week) {
		case 1:
			_return = [
				{
					title: "Report 1",
					addresses : [NAMES.EXECUTIVE, NAMES.JETSTREAM],
					letter_text: "Please ship ~0~ units of ~1~.",
					fields: [[FIELD_TYPES.NUMBER, "50"], [FIELD_TYPES.NOUN, "ice cream"]]
				},
				{
					title: "Newseletter 1",
					addresses : [NAMES.EXECUTIVE, NAMES.TIMES],
					letter_text: "Our company ~0~ is expected to increase by ~1~ percent",
					fields: [[FIELD_TYPES.NOUN, "stock"], [FIELD_TYPES.NUMBER, "1000"]]
				}
			]
			break;
			
		case 2:
			_return = [
				{
					title: "Acceptance 1",
					addresses : [NAMES.JETSTREAM, NAMES.EXECUTIVE],
					letter_text: "We ~0~ the order",
					fields: [[FIELD_TYPES.VERB, "shipped"]]
				},
				{
					title: "Sense 1",
					addresses : [NAMES.TIMES, NAMES.EXECUTIVE],
					letter_text: "This is great news. We will ~0~ this in ~1~.",
					fields: [[FIELD_TYPES.VERB, "publish"], [FIELD_TYPES.NOUN, "tomorrows paper"]]
				},
				{
					title: "Report 2",
					addresses : [NAMES.EXECUTIVE, NAMES.FINANCIAL],
					letter_text: "~0~ will be processed by the end of the month",
					fields: [[FIELD_TYPES.NOUN, "Layoffs"]]
				}
			]
			if (found_path(_path, "a")) {
					_return[0] = {
						title: "Rejection 1",
						addresses : [NAMES.JETSTREAM, NAMES.EXECUTIVE],
						letter_text: "1000 is way too many units of ice cream. No way.",
						fields: []
					}
			}
			if (found_path(_path, "b")) {
					_return[1] = {
						title: "Nonsense 1",
						addresses : [NAMES.TIMES, NAMES.EXECUTIVE],
						letter_text: "This story makes no sense, and your spot in the paper was ~0~.",
						fields: [[FIELD_TYPES.VERB, "cancelled"]]
					}
					array_push(_return, {
						title: "Scheme 1",
						addresses : [NAMES.TIMES, NAMES.JETSTREAM],
						letter_text: "Pentacorp is up to no good.",
						fields: []
					})
			}
			break;
	}
	return _return;
}

function get_path(_week, _letters) {
	var _return = "";
	switch (_week) {
		case 1:
			if (get_letter_title(_letters, "Report 1", 0, "1000")) _return = _return + "a";
			if (get_letter_title(_letters, "Newseletter 1", 0, "ice cream")) _return = _return + "b";
			break;
	}
	return _return;
}

function get_cutscene(_week, _path) {
	var _return = "";
	switch (_week) {
		case 1:
			_return = "default: The quick brown fox jumps over the lazy dog.";
			
			if (found_path(_path, "a")) {
				if found_path(_path, "b") {
					_return = "AB: The quick brown fox jumps over the lazy dog.";
				} else {
					_return = "A: The quick brown fox jumps over the lazy dog.";
				}
				
			} else if (found_path(_path, "b")) {
				_return = "B: The quick brown fox jumps over the lazy dog.";
			}
			break;
			
		case 2:
			_return = "week 2: The quick brown fox jumps over the lazy dog.";
			break;
	}
	return _return;
}

//helpers below

function found_path(_path, _char) {
	return string_pos(_char, _path) > 0;
}

function get_letter_title(_letters, _title, _field_index, _value) {
	for (var _i = 0; _i < array_length(_letters); _i ++) {
		if (_letters[_i].title == _title) {
			var _fields = _letters[_i].fields;
			return (_i < array_length(_fields) && _fields[_field_index][1] == _value);
		}
	}
	return false;
}