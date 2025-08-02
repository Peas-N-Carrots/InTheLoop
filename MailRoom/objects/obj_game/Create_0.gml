letters = []

function add_letter(_letter_data, _letter_name) {
	array_push(letters, create_letter(_letter_data[$ _letter_name]))
}

week = 0

global.game = self

var _letter_data = get_letter_data(1);

add_letter(_letter_data, "test_1")
add_letter(_letter_data, "test_2")
add_letter(_letter_data, "test_3")

//global.cabinet.get_mail()