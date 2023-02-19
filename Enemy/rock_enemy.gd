extends KinematicBody2D

export var is_magama:bool = false

var speed = 50
var motion = Vector2()
var dir = 1
var dead = false
var can_move = true
var can_animate = true

var points = 100

var random_idle
var idle_count = 0.0

var modifier = ""

func _ready():
	random_idle = PlayerGlobal.get_i_rand_range_num(1000, 10000)
	if is_magama:
		modifier = "r_"
		points += 50
	$AnimatedSprite.play(modifier + "walk")
	
func _physics_process(delta):
	if can_move:

		#Find direction
		if is_on_wall():
			dir *= -1
			flip()
		elif !$RayCast2D.is_colliding() and is_on_floor():
			$AnimatedSprite.play(modifier + "idle")
			dir *= -1
			flip()
			$IdleTimer.start()
			set_physics_process(false)
		motion.x = speed * dir
		
		if !is_on_floor():
			motion.y += Global.GRAVITY
		else: 
			motion.y = 0
		motion = move_and_slide(motion, Vector2.UP)
	
		if idle_count >= random_idle:
			random_idle = PlayerGlobal.get_i_rand_range_num(1000, 10000)
			$AnimatedSprite.play(modifier + "idle")
			$IdleTimer.start()
			idle_count = 0.0
			set_physics_process(false)
		else:
			idle_count += 0.5

func _on_JumpArea_body_entered(body):
	if body.is_in_group("player") and not dead:
		body.jump(1)
		dead = true
		can_move = false
		
		if is_magama:
			body.hurt(1)
		
		if points == 100:
			PlayerGlobal.add_score(points)
			points = 0 
		
		set_collision_mask_bit(0, 0)
		$HurtArea.monitoring = false
		$HurtArea2.monitoring = false
		$JumpArea.call_deferred("monitoring", false)
		$AnimatedSprite.play(modifier + "dead")
		$MoveTimer.start()
		
	elif is_magama and body.is_in_group("player"):
		body.hurt(1)

func hurt_area(body):
	if body.is_in_group("player"):
		body.hurt(1)
	
func flip():
	$RayCast2D.position.x *= -1
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
	
func _on_MoveTimer_timeout():
	dead = false
	$MoveTimer.stop()
	$AnimatedSprite.play(modifier + "resume")
	$ResumeTimer.start()
	set_collision_mask_bit(0, 1)
	$HurtArea.monitoring = true
	$HurtArea2.monitoring = true
	$JumpArea.monitoring = true


func _on_IdleTimer_timeout():
	self.set_physics_process(true)
	$AnimatedSprite.play(modifier + "walk")
	$IdleTimer.stop()


func _on_AnimatedSprite_animation_finished():
	pass


func _on_ResumeTimer_timeout():
	$ResumeTimer.stop()
	$AnimatedSprite.play(modifier + "walk")
	can_move = true
	
