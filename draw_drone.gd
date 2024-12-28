extends Node2D


func _draw():
	draw_base_drone()
	if get_parent().name.contains("drill_drone"):
		draw_colored_polygon([Vector2(40 *drill_bit_scale,-16*drill_bit_scale),Vector2(40*drill_bit_scale,40*drill_bit_scale),Vector2(80*drill_bit_scale,8*drill_bit_scale)],Color.DARK_GRAY)
	if get_parent().name.contains("defuse_drone"):
		draw_defuse()
	
	pass

@onready var drill_bit_scale = 0.5

@onready var drone_rect_size := 10
@onready var box_thickness := 2
@onready var box_color := Color.BLACK
@onready var box_filled :=true 

func draw_base_drone():
	draw_rect(Rect2(0.0, 0.0, drone_rect_size,drone_rect_size), Color.BLACK, false, box_thickness)
	draw_rect(Rect2(drone_rect_size,drone_rect_size , drone_rect_size, drone_rect_size), box_color, box_filled, box_thickness)
	draw_rect(Rect2(-drone_rect_size, -drone_rect_size, drone_rect_size, drone_rect_size), box_color, box_filled, box_thickness)
	draw_rect(Rect2(drone_rect_size, -drone_rect_size, drone_rect_size,drone_rect_size), box_color, box_filled, box_thickness)
	draw_rect(Rect2(-drone_rect_size, drone_rect_size, drone_rect_size, drone_rect_size), box_color, box_filled, box_thickness)

func draw_defuse():
	draw_rect(Rect2(45*drill_bit_scale, -25*drill_bit_scale, 36*drill_bit_scale, 75*drill_bit_scale), Color.BLUE, box_filled, box_thickness-1)