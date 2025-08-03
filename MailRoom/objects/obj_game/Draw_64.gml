var _camera = view_camera[0];

var _mouse_x = mouse_x - camera_get_view_x(_camera);
var _mouse_y = mouse_y - camera_get_view_y(_camera);

if (state = STATES.SWAPPING) {
	draw_carried_button(carried_button, _mouse_x + carried_button_offset_x, _mouse_y + carried_button_offset_y);
}

