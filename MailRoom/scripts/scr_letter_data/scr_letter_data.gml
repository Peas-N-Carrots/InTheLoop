enum FIELD_TYPES {
	NAME,
	NUMBER,
	OBJECT
}

function get_letter_data(_week){
	switch (_week) {
		case 1:
			return {
				test_1: {
					letter_text: "Dear ~0~,\n\nPlease produce ~1~ units of ~2~.\n\nSincerely,\n~3~",
					fields: [[FIELD_TYPES.NAME, "Production Team"], [FIELD_TYPES.NUMBER, "50"], [FIELD_TYPES.OBJECT, "ice cream"], [FIELD_TYPES.NAME, "Management"]]
				},
				test_2: {
					letter_text: "Dear ~0~,\n\nPlease produce ~1~ units of ~2~.\n\nSincerely,\n~3~",
					fields: [[FIELD_TYPES.NAME, "Production Team"], [FIELD_TYPES.NUMBER, "50"], [FIELD_TYPES.OBJECT, "ice cream"], [FIELD_TYPES.NAME, "Management"]]
				},
				test_3: {
					letter_text: "Dear ~0~,\n\nPlease produce ~1~ units of ~2~.\n\nSincerely,\n~3~",
					fields: [[FIELD_TYPES.NAME, "Production Team"], [FIELD_TYPES.NUMBER, "50"], [FIELD_TYPES.OBJECT, "ice cream"], [FIELD_TYPES.NAME, "Management"]]
				}
			}
		case 2:
			return {
				response_1: {
					letter_text: "Dear ~0~,\n\nPlease produce ~1~ units of ~2~.\n\nSincerely,\n~3~",
					fields: [[FIELD_TYPES.NAME, "Production Team"], [FIELD_TYPES.NUMBER, "50"], [FIELD_TYPES.OBJECT, "ice cream"], [FIELD_TYPES.NAME, "Management"]]
				}
			}
	}
}