extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().root.connect("size_changed",_on_viewport_size_change_resize_ui)
	%drop_off.connect("body_entered",_drop_off_area_entered)
	get_tree().root.content_scale_size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _drop_off_area_entered(body):
	print("body",body)
	var gems= body.get_node("%gems")
	for gem in gems.get_children():
		body.gems.remove_child(gem)
		add_child(gem)
		print(gem)
	body.add_to_group("idle_drones")
	body.remove_from_group("busy_drones")
	# print(body,body.owner)


func _on_drop_off_body_entered(body: Node2D) -> void:
	print(body)
	pass # Replace with function body.


@onready var viewport_start_size := Vector2(ProjectSettings.get_setting("display/window/size/viewport_height"), ProjectSettings.get_setting("display/window/size/viewport_width"))
func _on_viewport_size_change_resize_ui() -> void:
	# For changing the UI, we take the viewport size, which we set in the project settings.

	var current_window_size := DisplayServer.window_get_size();
	var resize_factor := Vector2(current_window_size) / Vector2(viewport_start_size)
	var average_resize_factor := (resize_factor.x+resize_factor.y)/2
	get_tree().root.set_content_scale_factor(average_resize_factor)
