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
@onready var utils:= get_tree().get_first_node_in_group("utils")


@onready var cell_type :={
	"bricks":{"id":1,"type":"drill_drone"},
	"gems":{"id":2,"type":"base_drone"},
	"bomb":{"id":3,"type":"defuse_drone"},
}

func _input(event: InputEvent) -> void:
		if Input.is_action_just_pressed("click"):
			travel_to_resource(cell_type.gems,"base_drone")
			travel_to_resource(cell_type.bricks,"drill_drone")
			travel_to_resource(cell_type.bomb,"defuse_drone")


func travel_to_resource(resource,drone_type:String)->void:
	if get_cell_source_id(local_to_map(get_global_mouse_position())) ==resource.id:
		var drone:= get_tree().get_first_node_in_group(utils.drone_state[drone_type].idle)
		if drone ==null: return
		if drone.is_in_group(utils.drone_state[drone_type].idle) and resource.type == drone_type:

			# drone.nav_agent.target_position = get_global_mouse_position()
			drone.nav_agent.target_position = (get_global_mouse_position())
			utils.update_drone_state_to_busy(drone,drone_type)

