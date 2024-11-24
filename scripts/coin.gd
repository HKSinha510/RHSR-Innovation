extends Area2D

@onready var game_manager: Node = %GameManager
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collect_sound: AudioStreamPlayer2D = $CollectSound

func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point()
	# Create a temporary audio player that will delete itself
	var temp_audio = AudioStreamPlayer.new()
	temp_audio.stream = collect_sound.stream
	temp_audio.finished.connect(func(): temp_audio.queue_free())
	get_tree().root.add_child(temp_audio)
	temp_audio.play()
	queue_free()
