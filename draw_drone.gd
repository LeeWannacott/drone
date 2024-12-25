extends Node2D


func _draw():
	draw_base_drone()
	if get_parent().name.contains("drill_drone"):
		draw_colored_polygon([Vector2(40,-16),Vector2(40,40),Vector2(80,8)],Color.DARK_GRAY)
	# if drone_type == "drill_drone":
	# 	draw_colored_polygon([Vector2(40,-16),Vector2(40,40),Vector2(80,8)],Color.DARK_GRAY)
	pass

func draw_base_drone():
	draw_rect(Rect2(0.0, 0.0, 20.0, 20.0), Color.BLACK, false, 2.0)
	draw_rect(Rect2(20.0, 20.0, 20.0, 20.0), Color.GREEN, false, 2.0)
	draw_rect(Rect2(-20.0, -20.0, 20.0, 20.0), Color.GREEN, false, 2.0)
	draw_rect(Rect2(20.0, -20.0, 20.0, 20.0), Color.GREEN, false, 2.0)
	draw_rect(Rect2(-20.0, 20.0, 20.0, 20.0), Color.GREEN, false, 2.0)
