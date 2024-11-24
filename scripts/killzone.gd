extends Area2D

@onready var timer = $Timer	
@onready var deadsound: AudioStreamPlayer2D = $deadsound

func _on_body_entered(body: Node2D) -> void:
	print("you died")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


	# Create a temporary audio player that will delete itself
	#var temp_audio = AudioStreamPlayer.new()
	#temp_audio.stream = deadsound.stream
	#temp_audio.finished.connect(func(): temp_audio.queue_free())
	#get_tree().root.add_child(temp_audio)
	#temp_audio.play()
	#queue_free()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
