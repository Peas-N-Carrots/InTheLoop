progress ++;
draw_set_color($4ce556);
draw_set_font(fnt_letter);
draw_text_ext(x, y, string_copy(text_value, 0, clamp(progress, 0, string_length(text_value))), 12, 260);
draw_set_color(c_white);