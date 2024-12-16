class_name SlimeDestroyState extends EnemyStateDestroy
	
func on_animation_finished(_current_animation: String):
	KillsRecord.killed("Slime")
	character.queue_free()
