switch (global.game.state) {
	case STATES.SETUP:
		if (point_distance(0, 0, speed_x, speed_y) > 1) {
			set_paper_position(x + speed_x, y + speed_y);
		
			var _fric = 0.9;
			speed_x *= _fric;
			speed_y *= _fric;
		} else {
			speed_x = 0;
			speed_y = 0;
		}
		
		set_paper_position(clamp(x, -200, 630), clamp(y, -264, 350));
		break;
		
	case STATES.CLEANUP:
		speed_y *= 1.1;
		set_paper_position(x + speed_x, y + speed_y);
		break;
		
	default:
		if (carried) {
			speed_x = mouse_x - prev_mouse_x;
			speed_y = mouse_y - prev_mouse_y;
		} else {
			if (point_distance(0, 0, speed_x, speed_y) > 1) {
				set_paper_position(x + speed_x, y + speed_y);
		
				var _fric = 0.9;
				speed_x *= _fric;
				speed_y *= _fric;
			} else {
				speed_x = 0;
				speed_y = 0;
			}
		}
		
		set_paper_position(clamp(x, -200, 630), clamp(y, -264, 350));
		break;
}

prev_mouse_x = mouse_x;
prev_mouse_y = mouse_y;

