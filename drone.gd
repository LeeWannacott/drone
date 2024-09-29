extends CharacterBody2D

@onready var nav_agent = %nav
@onready var gems = %gems

@onready var state ={
	0:"idle_drones",
	1:"busy_drones",
}

func _ready() -> void:
	%magnet_area.connect("area_entered",_magnet_area_entered)

@onready var rotors = [
	%rotor,
	%rotor2,
	%rotor3,
	%rotor4,
]

@onready var utils := get_tree().get_first_node_in_group("utils")
func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# nav_agent.target_position = target_position
	# nav_agent.target_position =get_global_mouse_position()
	for rotor in rotors:
		rotor.rotation_degrees+=1
	if utils.is_colliding(self):
		utils.get_push_vector(self,delta,2)
	if nav_agent.get_next_path_position():
		velocity = global_position.direction_to(nav_agent.get_next_path_position())*200
		# velocity = self.global_position.direction_to(Vector2(100,500))*100
		# direction = root.global_position.direction_to(player.global_position)
		rotation = lerp_angle(rotation, (velocity*delta).angle(),0.1)
		# if velocity !=Vector2():
		move_and_slide()



@onready var resources = get_tree().get_first_node_in_group("resources")

func _magnet_area_entered(area: Area2D) -> void:
	print(area,resources)
	resources.remove_child(area.owner)
	%gems.add_child(area.owner)
	area.owner.position = Vector2(0,0)
	nav_agent.target_position = (Vector2(0,0))
	pass # Replace with function body.

