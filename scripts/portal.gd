extends Area2D

@export var chase_speed: float = 50.0
@export var detection_range: float = 100.0

var player: CharacterBody2D = null
var is_chasing: bool = false

func _ready() -> void:
	if not has_node("CollisionShape2D"):
		print("Portal: WARNING - No CollisionShape2D found!")
	
	call_deferred("find_player")
	
func find_player() -> void:
	print("Portal: Searching for player...")
	var players = get_tree().get_nodes_in_group("player")
	
	if players.size() > 0:
		player = players[0]
		print("Portal: Found player at ", player.global_position)
	else:
		print("Portal: Could not find player in 'player' group")

func _physics_process(delta: float) -> void:
	if not player:
		find_player()
		return
		
	# Calculate distance to player
	var distance_to_player = global_position.distance_to(player.global_position)
	
	# Debug print every second
	if Engine.get_physics_frames() % 60 == 0:
		print("Portal: Distance to player = ", distance_to_player)
		print("Portal: Is chasing = ", is_chasing)
	
	# Start chasing if player is within range
	if distance_to_player <= detection_range:
		if not is_chasing:
			print("Portal: Started chasing!")
		is_chasing = true
	else:
		# Stop chasing if player is outside detection range
		if is_chasing:
			print("Portal: Stopped chasing - player out of range!")
		is_chasing = false
	
	# Move towards player if chasing
	if is_chasing:
		var direction = sign(player.global_position.x - global_position.x)
		position.x += direction * chase_speed * delta
