enum FIELD_TYPES {
	NAME,
	NUMBER,
	OBJECT
}

function get_letter_data(_week){
	switch (_week) {
		case 1:
			return {
				test_letter_1: {
					letter_text: "Dear ~1~,\nPlease produce ~2~ units of ~3~.\nSincerely,\n~4~",
					fields: [[FIELD_TYPES.NAME, "Production Team"], [FIELD_TYPES.NUMBER, "50"], [FIELD_TYPES.OBJECT, "ice cream"], [FIELD_TYPES.NAME, "Management"]]
				}
			}
	}
}