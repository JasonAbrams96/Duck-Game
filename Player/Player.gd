extends KinematicBody2D


var motion = Vector2()
var dir = 1
var speed = 150
var max_speed = 2500
var in_jump = false
var jump_force = 500
var is_invincible = false
var in_goal = false
var is_visible = true
var in_jumper = false

var has_hat = false
var hat_mod = ""
var can_move = true
var input_array = []
var hurt_timer_count = 0

var player_global = PlayerGlobal

onready var landing_raycast = $RayCast2D
onready var hurt_shader = $AnimatedSprite.material
onready var camera = $Camera2D
onready var vb_notifier = $VisibilityNotifier2D

func _ready():
	hurt_shader.set_shader_param("flash_modifier", 0.0)
	PlayerGlobal.player = self
	
func _physics_process(delta):
	
	#Jump landing comfort zone
	if landing_raycast.is_colliding():
		in_jump = false

	if in_goal:
		can_move = false
	if can_move:
		if is_on_floor() and in_jump:
			in_jump = false
		elif is_on_floor() and in_jumper:
			in_jumper = false
		elif !is_on_floor():
			motion.y += Global.GRAVITY
		else:
			motion.y = 0
			
		get_input()
		
		#motion = motion.normalized()
		
		if !in_jumper:
			var snap = Vector2.DOWN * 32 if !in_jump else Vector2.ZERO
			motion = move_and_slide_with_snap(motion, snap, Vector2.UP)
		elif in_jumper:
			motion = move_and_slide(motion, Vector2.UP)

func get_input():
	
	if Input.is_action_pressed("Left"):
		$AnimatedSprite.play(hat_mod + "walk")
		dir = -1
		motion.x = speed * dir
	elif Input.is_action_pressed("Right"):
		$AnimatedSprite.play(hat_mod + "walk")
		dir = 1
		motion.x = speed * dir
	else:
		$AnimatedSprite.play(hat_mod + "idle")
		motion.x = 0
	
	flip_image()
		
	if Input.is_action_pressed("Jump") and !in_jump:
		jump(0)
		
	if Input.is_action_just_pressed("Quack"):
		var q = (PlayerGlobal.rand.randi() % 4) + 1
		Global.create_sfx_audio("res://Assets/Audio/quack"+ String(q) + ".wav", self)
	
func flip_image():
	if dir == -1:
		$AnimatedSprite.flip_h = true
	elif dir == 1:
		$AnimatedSprite.flip_h = false

func jump(who_call):
	player_global.num_of_jumps += 1
	$AnimatedSprite.play(hat_mod + "jump")
	
	#	Player jumping
	if who_call == 0:
		in_jump = true
		motion.y -= jump_force
	
	#	Player falling on enemy	
	elif who_call == 1 and motion.y > 0:
		motion.y = 0
		motion.y -= jump_force * 1.25
		
	elif who_call == 2 and motion.y >= 0:
		in_jump = true
		in_jumper = true
		motion.y = 0
		motion.y -= jump_force * 1.5
		
	Global.create_sfx_audio("res://Assets/Audio/sfx_movement_jump5.wav", self)
	
func collect(name, amount, score):
		if name.to_upper() == "BREAD":
			player_global.bread += amount
			PlayerGlobal.score += score
			PlayerGlobal.emit_signal("score_updated", PlayerGlobal.score)
			PlayerGlobal.emit_signal("bread_updated", PlayerGlobal.bread)
			
		elif name.to_upper() == "HAT":
			PlayerGlobal.score += score
			PlayerGlobal.emit_signal("score_updated", PlayerGlobal.score)
			hat_mod = "h_"
			
		elif name.to_upper() == "SPECIAL":
			PlayerGlobal.score += score
			PlayerGlobal.emit_signal("score_updated", PlayerGlobal.score)
			enable_special()

func enable_special():
	print("enabled_special")
	
func hurt(damage):
	if !is_invincible:
		if hat_mod != "":
			hat_mod = ""
		else:
			player_global.health -= 1
		$HurtTimer.start()
		is_invincible = true
		PlayerGlobal.emit_signal("health_updated", player_global.health)
		var damage_sound = String(PlayerGlobal.rand.randi() % 3  + 1 )
		Global.create_sfx_audio("res://Assets/Audio/damage" + damage_sound + ".wav", self)
		
func change_camera_location(gl: Vector2):
	camera.global_position = gl
	
func toggle_vb_notifier():
	is_visible = !is_visible
	
func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.is_in_group("platform") and in_jump:
		in_jump = false
		$AnimatedSprite.play(hat_mod + "land")


func _on_HurtTimer_timeout():
	
	if hurt_timer_count % 2 == 0:
		hurt_shader.set_shader_param("flash_modifier", 1.0)
	else:
		hurt_shader.set_shader_param("flash_modifier", 0.0)
	
	if hurt_timer_count == 7:
		is_invincible = false
		hurt_timer_count = 0
		$HurtTimer.stop()

	hurt_timer_count += 1
	


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	
	if !in_goal and is_visible:
		GlobalTransition.is_death_transition = true
		get_tree().change_scene_to(GlobalTransition.transition)