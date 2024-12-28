extends CharacterBody2D


@onready var drone_speed :=60
@onready var nav_agent = %nav
@onready var gems = %gems
@onready var is_disabled:=false


@onready var drone_type:=""
func _ready() -> void:
	%magnet_area.connect("area_entered",_magnet_area_entered)
	# %drill_area.connect("body_entered",_drill_wall)
	pass


@onready var rotors = [
	%rotor,
	%rotor2,
	%rotor3,
	%rotor4,
]
@onready var drill_progress_bar= preload("uid://3oi7u3htl36")
@onready var world := get_tree().get_first_node_in_group("world")
@onready var utils := get_tree().get_first_node_in_group("utils")


static var drilled_tiles = { }
static var drilling_time := 6
@onready var blade_count:=1
func _physics_process(delta: float) -> void:
	# if nav_agent.is_navigation_finished() and %soft_collision.has_overlapping_areas(): utils.get_push_vector(self,delta,1)
	if nav_agent.get_next_path_position() and is_in_group(utils.drone_state[drone_type].busy):
		velocity = global_position.direction_to(nav_agent.get_next_path_position())*drone_speed
		rotation = lerp_angle(rotation, (velocity*delta).angle(),0.2)
		position += velocity *delta
		move_and_slide()
	
	if drone_type == "drill_drone":
		if %drill_area.has_overlapping_bodies():
			var drill_tile_location = resources.local_to_map(%drill_collision.global_position)
			if !drilled_tiles.has(drill_tile_location) and resources.get_cell_source_id(drill_tile_location)!=-1:
				drilled_tiles[drill_tile_location]=true
				utils.update_drone_state_to_busy(self,drone_type)
				var new_progress_bar :=drill_progress_bar.instantiate()
				new_progress_bar.global_position =resources.map_to_local(drill_tile_location)-Vector2(32,32)
				world.add_child(new_progress_bar)
				is_disabled=true
				await create_tween().tween_property(new_progress_bar.get_node("%drill_progress_bar"),"value",100,2).finished
				is_disabled=false
				utils.update_drone_state_to_idle(self,drone_type)
				# resources.get_cell_source_id(drill_tile_location)
				resources.set_cell(drill_tile_location,-1)
				world.get_node("%navigation_region").bake_navigation_polygon()
				new_progress_bar.queue_free()

@onready var resources = get_tree().get_first_node_in_group("resources")

func _magnet_area_entered(area: Area2D) -> void:
	if drone_type == "base_drone":
		resources.remove_child(area.owner)
		%gems.add_child(area.owner)
		area.owner.position = Vector2(0,0)
		nav_agent.target_position = (Vector2(0,0))
	pass # Replace with function body.

func _draw():
	# draw_base_drone()
	# if drone_type == "drill_drone":
		# draw_drill_bit()
	# if drone_type == "defuse_drone":
	# 	draw_defuse()
	pass

@onready var drill_bit_scale = 1.0
@onready var drone_rect_size := 20
@onready var box_thickness := 2
@onready var box_color := Color.BLACK
@onready var box_filled :=true 
func draw_base_drone():
	draw_rect(Rect2(0.0, 0.0, drone_rect_size,drone_rect_size), Color.BLACK, false, box_thickness)
	draw_rect(Rect2(drone_rect_size,drone_rect_size , drone_rect_size, drone_rect_size), box_color, box_filled, box_thickness)
	draw_rect(Rect2(-drone_rect_size, -drone_rect_size, drone_rect_size, drone_rect_size), box_color, box_filled, box_thickness)
	draw_rect(Rect2(drone_rect_size, -drone_rect_size, drone_rect_size,drone_rect_size), box_color, box_filled, box_thickness)
	draw_rect(Rect2(-drone_rect_size, drone_rect_size, drone_rect_size, drone_rect_size), box_color, box_filled, box_thickness)

@onready var line_scale = 1
@onready var blade_colour = Color.BLACK
@onready var blade_thickness = 2
func draw_drill_bit():
		draw_colored_polygon([Vector2(40 *drill_bit_scale,-16*drill_bit_scale),Vector2(40*drill_bit_scale,40*drill_bit_scale),Vector2(80*drill_bit_scale,8*drill_bit_scale)],Color.DARK_GRAY)
		draw_line(Vector2(75*line_scale, 5*line_scale), Vector2(75*line_scale, 14*line_scale), blade_colour, blade_thickness)
		draw_line(Vector2(65*line_scale, -5*line_scale), Vector2(65*line_scale, 20*line_scale), blade_colour, blade_thickness)
		draw_line(Vector2(55*line_scale, -8*line_scale), Vector2(55*line_scale, 28*line_scale), blade_colour, blade_thickness)
		draw_line(Vector2(45*line_scale, -13*line_scale), Vector2(45*line_scale, 35*line_scale), blade_colour, blade_thickness)

func draw_defuse():
	draw_rect(Rect2(45, -25, 36, 75), Color.BLUE, box_filled, box_thickness-1)

func _drill_wall(body):
	# if body.name.contains("resources"):
	print("area: ")
	print("area: ",body,resources.local_to_map(%drill_collision.global_position))
