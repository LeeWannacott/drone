extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


var mouse_on_gem :bool=false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# func _input(event: InputEvent) -> void:
# 	if event.button_mask==1:
# 		print(get_cell_source_id(Vector2i(get_global_mouse_position())))
# 	print(event)
# @onready var drone = get_tree().get_first_node_in_group("idle_drones")
@onready var harvested_cells = {}
func _input(event: InputEvent) -> void:
		if Input.is_action_just_pressed("click"):

			# print(get_cell_source_id(local_to_map(get_global_mouse_position())))
				# print(get_cell_source_id(local_to_map(get_global_mouse_position())))
			print(local_to_map(get_global_mouse_position()))
			if get_cell_source_id(local_to_map(get_global_mouse_position())) ==2:
				var drone:= get_tree().get_first_node_in_group("idle_drones")
				if drone ==null: return
				if !drone.is_in_group("busy_drones"):

					# drone.nav_agent.target_position = get_global_mouse_position()
					drone.nav_agent.target_position = (get_global_mouse_position())
					drone.remove_from_group("idle_drones")
					drone.add_to_group("busy_drones")
