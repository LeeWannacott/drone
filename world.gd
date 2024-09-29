extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%drop_off.connect("body_entered",_drop_off_area)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _drop_off_area(body):
	for gem in body.gems.get_children():
		body.gems.remove_child(gem)
		add_child(gem)
	body.add_to_group(body.state[0])
	body.remove_from_group(body.state[1])
	print(body,body.owner)
