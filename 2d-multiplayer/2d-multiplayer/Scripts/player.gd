extends CharacterBody2D


const SPEED = 300.0
@onready var camera = $Camera2D

func _enter_tree() -> void:
	set_multiplayer_authority(str(name).to_int())
	
#func _ready() -> void:
	#if !is_multiplayer_authority(): return
func _ready() -> void:
	position = Vector2(640, 360)
func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return

	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * SPEED 
	move_and_slide()

	camera.make_current()
