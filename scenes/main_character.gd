extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -450.0
const GRAVITY = 1500.0

var coin_counter = 0
@onready var coin_label: Label = $Label
@onready var animated_sprite: AnimatedSprite2D = $Sprite2D

func _ready() -> void:
	$Label2.visible = false
	
func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		animated_sprite.animation = "jumping"
		animated_sprite.play()
	else:
		# Stop vertical motion if on floor
		velocity.y = 0.0
		# Handle idle or running animation
		if abs(velocity.x) > 1:
			animated_sprite.animation = "running"
		else:
			animated_sprite.animation = "default"
		animated_sprite.play()

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle horizontal movement
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Apply movement
	move_and_slide()
	var isLeft = velocity.x < 0
	animated_sprite.flip_h = isLeft
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		set_coin(coin_counter + 1)
		area.queue_free()  # Optional: remove the coin from the scene
	
	if coin_counter >= 20:
		$Label2.visible= true

func set_coin(new_coin_count: int) -> void:
	coin_counter = new_coin_count
	coin_label.text = "Coin Count: " + str(coin_counter)
	
