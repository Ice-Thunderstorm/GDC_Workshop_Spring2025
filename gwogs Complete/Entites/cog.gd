@icon("res://World/Cog.png")
# ^This sets the scene's icon if you want to change it
extends Node2D

# A function to delete itself
func delete():
	self.queue_free()
