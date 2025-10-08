extends CharacterBody2D

@export var speed: float = 1000.0
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	# --- Lógica de Movimento ---
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1

	velocity = input_vector.normalized() * speed
	move_and_slide()

	# --- Lógica de Animação ---
	update_animation(input_vector)

func update_animation(input_vector: Vector2) -> void:
	var new_anim: String

	# Determina qual animação deveria estar tocando
	if input_vector != Vector2.ZERO:
		new_anim = "walk_side"
		anim_sprite.flip_h = input_vector.x < 0
	else:
		new_anim = "idle"

	# Só executa o play() se a nova animação for diferente da atual
	if anim_sprite.animation != new_anim:
		anim_sprite.play(new_anim)
