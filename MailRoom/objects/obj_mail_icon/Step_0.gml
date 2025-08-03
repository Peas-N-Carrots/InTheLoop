progress += 1/40;

var _t = progress;
var _one_minus_t = 1 - _t;

x = (_one_minus_t * _one_minus_t * x_1) + 
	(2 * _one_minus_t * _t * x_2) + 
	(_t * _t * x_3);

y = (_one_minus_t * _one_minus_t * y_1) + 
	(2 * _one_minus_t * _t * y_2) + 
	(_t * _t * y_3);

if (progress >= 1) instance_destroy();
