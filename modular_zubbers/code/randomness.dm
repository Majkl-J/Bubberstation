#define TWO_COS(A) (1+2*cos(A))/3
#define MINUS_SIN(A) (((1-cos(A))/3) - (sin(A)/sqrt(3)))
#define PLUS_SIN(A) (((1-cos(A))/3) + (sin(A)/sqrt(3)))

/obj/item/proc/apply_hue_shift(angle)
	var/list/color_matrix = list( \
		TWO_COS(angle), MINUS_SIN(angle), PLUS_SIN(angle), 0,\
		PLUS_SIN(angle), TWO_COS(angle), MINUS_SIN(angle), 0,\
		MINUS_SIN(angle), PLUS_SIN(angle), TWO_COS(angle), 0,\
		0,0,0,1
	)
	color = color_matrix
	return 1
