extends CharacterBody2D

##################################################
enum STATE {
	IDLE_L,
	IDLE_R,
	WALK_L,
	WALK_R,
	SHOOT_L,
	SHOOT_R,
}
# 상태 관리를 위한 열거형 변수

enum DIRECTION {
	LEFT,
	RIGHT
}
# 좌우 방향 관리를 위한 열거형 변수

const BULLET_SCENE = preload("res://scenes/bullet/bullet.tscn")
# 총알 씬 미리 불러오기

const SPEED: float = 300.0
# 이동 속도
const JUMP_VELOCITY: float = -400.0
# 점프 강도
const BULLET_OFFSET: Vector2 = Vector2(0.0, 14.0)
# 총알 발사 시 발사 좌표 offset

var anim_node: AnimatedSprite2D
var fire_l_node: Sprite2D
var fire_r_node: Sprite2D
var camera_node: Camera2D
# 각 노드 선언

var state: STATE
# 현재 상태 값
var player_direction: DIRECTION
# 현재 방향 값

##################################################
func _ready() -> void:
	anim_node = $AnimatedSprite2D
	
	fire_l_node = $FireLSprite2D
	fire_r_node = $FireRSprite2D
	fire_l_node.visible = false
	fire_r_node.visible = false
	# 각 노드 초기화 및 설정
	
	camera_node = $Camera2D
	camera_node.position_smoothing_enabled = true
	# 각 노드 초기화 및 설정. 카메라 지연 이동을 위한 설정
	
	add_to_group("Player")
	# Player 그룹에 추가
	
	state = STATE.IDLE_R
	# 현재 상태 값 초기화
	player_direction = DIRECTION.RIGHT
	# 현재 방향 값 초기화

##################################################
func _physics_process(delta: float) -> void:
	if not is_on_floor():
	# 지면에 닿아있지 않을 때
		velocity += get_gravity() * delta
		# 중력 적용

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	# 지면에서 스페이스 키를 누르면
		velocity.y = JUMP_VELOCITY
		# 점프
	elif Input.is_action_just_pressed("p_ui_left_click"):
	# 마우스 좌클릭을 하면
		if player_direction == DIRECTION.LEFT:
			state = STATE.SHOOT_L
		else:
			state = STATE.SHOOT_R
		# 플레이어 방향에 따른 상태값 설정
		
		SM.fire_sound_play()
		# 총알 발사 효과음 재생
		
		fire_bullet(player_direction)
		# 총알 생성 및 발사 함수 실행
	else:
	# 나머지 경우
		var input: float = Input.get_axis("p_ui_left", "p_ui_right")
		# 좌우 입력 값을 input에 설정
		if input:
		# 좌우 입력이 있다면
			velocity.x = input * SPEED
			if input < 0:
				state = STATE.WALK_L
			else:
				state = STATE.WALK_R
			# 플레이어 상태 값 설정 및 이동을 위한 velocity 설정
		elif input == 0 and state < STATE.SHOOT_L:
		# 좌우 입력이 없고, 총알을 발사하는 상태가 아니라면
			velocity.x = move_toward(velocity.x, 0, SPEED)
			# 좌우 이동 속도 0에 수렴하도록 정지
			if player_direction == DIRECTION.LEFT:
				state = STATE.IDLE_L
			else:
				state = STATE.IDLE_R
			# 플레이어 방향에 따라 상태 값 설정
		
		if not anim_node.is_playing():
		# 애니메이션 재생 중이 아니라면(이동 중이거나 총알 발사 상태가 아니라면)
			if player_direction == DIRECTION.LEFT:
				state = STATE.IDLE_L
			else:
				state = STATE.IDLE_R
			# 방향에 따라 상태 값 설정
	
	set_state(state)
	# 상태에 따른 애니메이션 등 설정 및 재생
	move_and_slide()
	# 물리 적용

##################################################
func set_state(state_value: STATE) -> void:
# 상태에 따른 애니메이션 등 설정 및 재생 함수
	match state_value:
		STATE.IDLE_L:
			anim_node.flip_h = true
			anim_node.play("idle_r")
			player_direction = DIRECTION.LEFT
			fire_visible(false)
		STATE.IDLE_R:
			anim_node.flip_h = false
			anim_node.play("idle_r")
			player_direction = DIRECTION.RIGHT
			fire_visible(false)
		STATE.WALK_L:
			anim_node.flip_h = true
			anim_node.play("walk_r")
			player_direction = DIRECTION.LEFT
			fire_visible(false)
		STATE.WALK_R:
			anim_node.flip_h = false
			anim_node.play("walk_r")
			player_direction = DIRECTION.RIGHT
			fire_visible(false)
		STATE.SHOOT_L:
			anim_node.flip_h = true
			anim_node.play("shoot_r")
			player_direction = DIRECTION.LEFT
			fire_visible(true)
		STATE.SHOOT_R:
			anim_node.flip_h = false
			anim_node.play("shoot_r")
			player_direction = DIRECTION.RIGHT
			fire_visible(true)

##################################################
func fire_visible(visible_value: bool) -> void:
# 총알 발사 시 총구 불 나타내는 함수
	if visible_value:
	# 총알 발사 시
		if player_direction == DIRECTION.LEFT:
			fire_l_node.visible = true
		else:
			fire_r_node.visible = true
		# 방향에 따라 총구 불 보이도록 설정
	else:
		fire_l_node.visible = false
		fire_r_node.visible = false
	# 발사 시가 아니면 봉구 불이 안 보이도록 설정

##################################################
func fire_bullet(direction_value: DIRECTION) -> void:
# 총알 생성 및 발사 함수
	var bullet_instance = BULLET_SCENE.instantiate()
	# 인스턴스 생성
	get_tree().get_nodes_in_group("Bullets").front().add_child(bullet_instance)
	# Bullets 그룹인 노드를 찾아(어차피 하나) 자식 노드로 추가
	# 플레이어 노드 자식으로 추가하면 총알이 실시간으로 플레이어 좌표를 따라감
	bullet_instance.global_position = global_position + BULLET_OFFSET
	# offset에 따라 좌표 설정
	
	if direction_value == DIRECTION.LEFT:
		bullet_instance.set_direction(true)
	else:
		bullet_instance.set_direction(false)
	# 플레이어 방향에 따라 set_direction 함수로 총알 발사 방향도 설정
