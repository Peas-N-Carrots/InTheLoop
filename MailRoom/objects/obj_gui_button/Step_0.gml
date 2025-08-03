if (!script_exists(active_script) || script_execute(active_script)) {
	visible = true;
	if (position_meeting(mouse_x, mouse_y, self)) {
		if (mouse_check_button_pressed(mb_left)) {
			image_index = 2;
			if (script_exists(action_script) && (!script_exists(condition_script) || script_execute(condition_script))) {
				script_execute(action_script);
			}
		} else {
			image_index = 1;
		}
	} else {
		image_index = 0;
	}
} else {
	visible = false;
}