extends Node2D

# Everytime a cog deletes the level tracks it 
func _on_cogs_child_exiting_tree(node: Node) -> void:
	if $CogsGroup.get_child_count()-1 == 0:
		# Once there are no more cogs it starts the timer and reveals the win lable
		$Timer.start()
		$Player/Label2.visible = true


func _on_timer_timeout() -> void:
	# Restarts Level when timer runs out
	get_tree().reload_current_scene()
