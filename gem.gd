extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


@onready var utils := get_tree().get_first_node_in_group("utils")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if utils.is_colliding(self):
		utils.get_push_vector(self,delta,2)
	pass

