extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var resources := get_tree().get_first_node_in_group("resources")
func _ready() -> void:
	%mine_sprite.visible=true
	connect("mouse_entered",_set_mouse_on_gem.bind(true))
	connect("mouse_exited",_set_mouse_on_gem.bind(false))
	%mine_area.connect("area_entered",_mine_area_entered)


@onready var utils := get_tree().get_first_node_in_group("utils")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# if utils.is_colliding(self):
	# 	utils.get_push_vector(self,delta,2)
	pass

@onready var blade_colour = Color.DARK_RED
@onready var blade_thickness = 2
@onready var line_scale = 3
func _draw():
	if %mine_sprite.visible:
		#diagonals	
		draw_line(Vector2(-7*line_scale, 7*line_scale), Vector2(7*line_scale, -7*line_scale),blade_colour, blade_thickness)
		draw_line(Vector2(-7*line_scale, -7*line_scale), Vector2(7*line_scale, 7*line_scale), blade_colour, blade_thickness)
		#straight across
		draw_line(Vector2(0*line_scale, -10*line_scale), Vector2(0*line_scale, 10*line_scale), blade_colour, blade_thickness)
		draw_line(Vector2(-10*line_scale, 0*line_scale), Vector2(10*line_scale, 0*line_scale), blade_colour, blade_thickness)

func _set_mouse_on_gem(value: bool) -> void:
	resources.mouse_on_gem = value
	pass # Replace with function body.

func _mine_area_entered(area):
	print(area)
	if area.name.contains("drill"):
		%animated_sprite_2d.play("explosion")
		print("boide",%explosion_area.get_overlapping_bodies())
		var drones = %explosion_area.get_overlapping_bodies()
		for drone in drones:
			drone.queue_free()
			utils.update_drone_amount_label(drone.drone_type)
		await get_tree().create_timer(1).timeout
		%mine_sprite.visible=false
		queue_redraw()
		await %animated_sprite_2d.animation_finished
		queue_free()
		

		
