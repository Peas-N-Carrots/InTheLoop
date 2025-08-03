var _color = c_dkgray;
var _alpha = 0.15;

if (!carried) {
	_color = global.colors[$ field_type];
	_alpha = BUTTON_OPACITY;
}

if (!global.game.swapped && (!global.game.carried_button || global.game.carried_button.field_type == field_type)) {
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _color, _alpha);
}