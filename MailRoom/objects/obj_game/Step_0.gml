script_execute(state_map[$ state]);


if keyboard_check_pressed(vk_space) {
	if (instance_exists(obj_letter)) {
		with (obj_letter) {
			swap_field(0, "Fart-Face")
		}
	}
}