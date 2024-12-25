using System;
using Godot;
using Godot.Collections;


// Called when the node enters the scene tree for the first time.
[GlobalClass]
public partial class World : Godot.Node2D
{
	public override void _Ready()
	{
		var dropOff = (Area2D)GetNode("%drop_off");
		// .Connect(Area2D.SignalName.BodyEntered, Callable.From(_DropOffArea));
		dropOff.AreaEntered += DropOffArea;
		// Replace with function body.
	}


	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)

	{
	}

	private void DropOffArea(Node2D body)
	{
		// if (body is drone)
		{
			var Gems = (Node2D)body.GetNode("%gems");
			foreach (Gem gem in Gems.GetChildren())
			{
				Gems.RemoveChild(gem);
				AddChild(gem);
			}
			body.AddToGroup("idle_drones");
			body.RemoveFromGroup("busy_drones");
			GD.Print(body, body.Owner);
		}
	}
}
