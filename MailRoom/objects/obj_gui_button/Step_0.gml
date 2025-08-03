if (position_meeting(mouse_x, mouse_y, self) && mouse_check_button_pressed(mb_left)) {
	if (script_exists(action_script) && (!script_exists(condition_script) || script_execute(condition_script))) {
		script_execute(action_script);
	}
}