using Godot;
using Godot.Collections;


// Called when the node enters the scene tree for the first time.
[GlobalClass]
public partial class Resources : TileMapLayer
{
	public override void _Ready()
	{
		// Replace with function body.
	}


	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{

	}

	// func _input(event: InputEvent) -> void:
	// 	if event.button_mask==1:
	// 		print(get_cell_source_id(Vector2i(get_global_mouse_position())))
	// 	print(event)
	// @onready var drone = get_tree().get_first_node_in_group("idle_drones")
	public override void _Input(InputEvent @event)
	{
		if(Godot.Input.IsActionJustPressed("click"))
		{

			// print(get_cell_source_id(local_to_map(get_global_mouse_position())))
			if(GetCellSourceId(LocalToMap(GetGlobalMousePosition())) == 1)
			GD.Print("kjlk");
			{

				// print(get_cell_source_id(local_to_map(get_global_mouse_position())))
				if(GetCellSourceId(LocalToMap(GetGlobalMousePosition())) == 2)
				{
					var drone = (Drone) GetTree().GetFirstNodeInGroup("idle_drones");
					if(drone == null)
					{return ;
					}
					if(!drone.IsInGroup((string)drone.State[1]))
					{
						GD.Print(GetCellSourceId(LocalToMap(GetGlobalMousePosition())));

						// drone.nav_agent.target_position = get_global_mouse_position()
						drone.NavAgent.TargetPosition = (GetGlobalMousePosition());
						drone.RemoveFromGroup((string)drone.State[0]);
						drone.AddToGroup((string)drone.State[1]);
					}
				}
			}
		}
	}


}