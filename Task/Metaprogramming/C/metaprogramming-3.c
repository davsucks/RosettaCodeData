#define my_min(x, y) ((x) < (y) ? (x) : (y))
...
printf("%f %d %ll\n", my_min(0.0f, 1.0f), my_min(1,2), my_min(1ll, 2ll));