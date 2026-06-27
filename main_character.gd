extends CharacterBody2D

var speed = 120
var run_speed = 150
var jump_force = -344
var gravity = 1000

var dash_speed = 270
var dash_duration = 0.2
var is_dashing = false
var dash_timer = 0.0

var is_running = false
var last_left_tap = 0.0
var last_right_tap = 0.0
var double_tap_time = 0.25

var coins = 0

var on_ladder = false
var climb_speed = 100

var max_health = 4
var invincible = false
var is_hurt = false
var is_dead = false

@onready var anim = $AnimatedSprite2D
@onready var death_screen = $"../DeathScreen"
@onready var hurt_sound = $HurtSound

func _ready():
	coins = GameManager.total_coins
	var counter = get_tree().get_first_node_in_group("coin_counter")
	if counter:
		counter.text = str(coins)
	var health_bar = get_tree().get_first_node_in_group("health_bar")
	if health_bar:
		health_bar.update_health(GameManager.health)

func take_damage(amount):

	if invincible or is_dead:
		return
	invincible = true
	is_hurt = true
	hurt_sound.play()
	GameManager.health = max(GameManager.health - amount, 0)

	var health_bar = get_tree().get_first_node_in_group("health_bar")
	if health_bar:
		health_bar.update_health(GameManager.health)

	if GameManager.health <= 0:
		is_dead = true
		is_hurt = false
		anim.play("Death")
		await anim.animation_finished
		death_screen.player_died()
		return

	anim.play("Hurt")
	await anim.animation_finished
	is_hurt = false
	await get_tree().create_timer(1.0).timeout
	invincible = false

func add_coin():
	coins += 1
	GameManager.total_coins = coins
	var counter = get_tree().get_first_node_in_group("coin_counter")
	if counter:
		counter.text = str(coins)

func _on_area_2d_area_entered(area):
	if area.is_in_group("ladder"):
		on_ladder = true

func _on_area_2d_area_exited(area):
	if area.is_in_group("ladder"):
		on_ladder = false

func _physics_process(delta):
	if is_dead:
		return
	if is_hurt:
		move_and_slide()
		return
	# LADDER Bro ...
	if on_ladder:
		velocity.y = 0

		if Input.is_action_pressed("climb_up"):
			velocity.y = -climb_speed

		if Input.is_action_pressed("climb_down"):
			velocity.y = climb_speed

	else:
		if !is_on_floor():
			velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		$JumpSound.play()

	var direction = Input.get_axis("move_left", "move_right")

	if Input.is_action_just_pressed("move_left"):
		var current_time = Time.get_ticks_msec() / 1000.0
		if current_time - last_left_tap < double_tap_time:
			is_running = true
		last_left_tap = current_time

	if Input.is_action_just_pressed("move_right"):
		var current_time = Time.get_ticks_msec() / 1000.0
		if current_time - last_right_tap < double_tap_time:
			is_running = true
		last_right_tap = current_time

	if direction == 0:
		is_running = false

	if Input.is_action_just_pressed("dash") and direction != 0 and !is_dashing:
		is_dashing = true
		dash_timer = dash_duration
		$DashSound.play()

	if is_dashing:
		velocity.x = direction * dash_speed
		dash_timer -= delta

		if dash_timer <= 0:
			is_dashing = false

	else:
		if direction != 0:
			if is_running:
				velocity.x = direction * run_speed
			else:
				velocity.x = direction * speed

			anim.flip_h = direction < 0
		else:
			velocity.x = 0

	# ANIMATIONS to work all the animation things
	if !is_dashing and !is_hurt:
		if on_ladder:
			anim.play("Climb")
		elif !is_on_floor():
			anim.play("Jump")
		elif direction != 0:
			if is_running:
				anim.play("Run")
			else:
				anim.play("Walk")
		else:
			anim.play("Ideal")

	move_and_slide()
