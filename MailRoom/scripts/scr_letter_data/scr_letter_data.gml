enum FIELD_TYPES {
	DATE,
	NUMBER,
	COST,
	NOUN,
	VERB
}

function get_letter_data(_week){
	switch (_week) {
		case 1:
			return {
				test_1: {
					letter_text: "Dear ~0~,\n\nPlease produce ~1~ units of ~2~.\n\nSincerely,\n~3~",
					fields: [[FIELD_TYPES.NOUN, "Production Team"], [FIELD_TYPES.NUMBER, "50"], [FIELD_TYPES.NOUN, "ice creammmmmmmm"], [FIELD_TYPES.NOUN, "Management"]]
				},
				test_2: {
					letter_text: "1234567890123456789012345678901 hi",
					fields: []
				},
				test_3: {
					letter_text: "Dear ~0~,\n\nPlease produce ~1~ units of ~2~.\n\nSincerely,\n~3~",
					fields: [[FIELD_TYPES.NOUN, "Production Team"], [FIELD_TYPES.NUMBER, "50"], [FIELD_TYPES.NOUN, "ice cream"], [FIELD_TYPES.NOUN, "Management"]]
				}
			}
		case 2:
			return {
				response_1: {
					letter_text: "Dear ~0~,\n\nPlease produce ~1~ units of ~2~.\n\nSincerely,\n~3~",
					fields: [[FIELD_TYPES.NOUN, "Production Team"], [FIELD_TYPES.NUMBER, "50"], [FIELD_TYPES.NOUN, "ice cream"], [FIELD_TYPES.NOUN, "Management"]]
				}
			}
	}
}