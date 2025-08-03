var _shadow_dist = 1;
if (carried) _shadow_dist = 5

draw_set_color(c_black);
draw_set_alpha(0.1);
draw_rectangle(bbox_left+_shadow_dist,bbox_top+_shadow_dist,bbox_right+_shadow_dist,bbox_bottom+_shadow_dist,false);
draw_set_color(c_white);
draw_set_alpha(1);

draw_self();
draw_letter_text(x, y, output_text, line_starts);
