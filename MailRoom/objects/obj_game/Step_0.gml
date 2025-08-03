script_execute(state_map[$ state]);

var _layer_id = layer_background_get_id("Background");
switch (state) {
	case STATES.FREE: case STATES.PICK_UP: case STATES.SWAPPING: case STATES.CLEANUP: case STATES.SETUP:
		layer_background_sprite(_layer_id, spr_bg_1);
		layer_background_blend(_layer_id, c_white);
		break;
	default:
		layer_background_sprite(_layer_id, -1);
		layer_background_blend(_layer_id, c_black);
		break;
}