if (wait1 >= 0) {
	wait1 --;
} if (wait2 >= 0) {
	wait2 --;
	if (wait2 == 0) instance_destroy();
} else {
	progress += 1/60;

	var _t = progress;
	var _one_minus_t = 1 - _t;

	x = (_one_minus_t * _one_minus_t * x_1) + 
		(2 * _one_minus_t * _t * x_2) + 
		(_t * _t * x_3);

	y = (_one_minus_t * _one_minus_t * y_1) + 
		(2 * _one_minus_t * _t * y_2) + 
		(_t * _t * y_3);

	if (progress >= 1) {
		wait2 = 40;
		x = x_3;
		y = y_3;
	}
}