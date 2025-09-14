extends CharacterBody2D


const SPEED = 300.0

func _enter_tree() -> void:
	set_multiplayer_authority(str(name).to_int())
	
#func _ready() -> void:
	#if !is_multiplayer_authority(): return

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * SPEED 

	move_and_slide()
