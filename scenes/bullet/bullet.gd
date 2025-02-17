extends Area2D

##################################################
const MOVING_SPEED: float = 1000.0
# 움직임 석도

var direction: Vector2
# 방향
var sprite_node: Sprite2D
# Sprite2D 노드
var start_position: Vector2
# 시작 좌표

##################################################
func _ready() -> void:
	z_index = -1
	# 플레이어 뒤에서 그려지도록 설정
	sprite_node = $Sprite2D
	# sprite_node 설정
	start_position = global_position
	# bullet이 player 좌표에서 생성되어 start_position 설정
	
	connect("body_entered", Callable(self, "_on_body_entered"))
	# body_entered 시 _on_body_entered 함수와 연결

##################################################
func _process(delta: float) -> void:
	position.x += delta * MOVING_SPEED * direction.x
	# 좌우로 이동

##################################################
func set_direction(is_left: bool) -> void:
# player가 총알 발사 시 설정하는 함수
	if is_left:
		direction = Vector2(-1, 0)
		sprite_node.flip_h = true
	else:
		direction = Vector2(1, 0)
	# 방향에 따라 스프라이트 좌우 반전 및 방향 설정

##################################################
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Background"):
		queue_free()
		SM.hit_sound_play()
	# Background 그룹에 충돌 시 노드 삭제 및 충돌 효과음 재생
	elif body.is_in_group("Enemy"):
		body.queue_free()
		queue_free()
		SM.hit_sound_play()
	# Enemy 그룹에 충돌 시 적과 총알 노드 삭제 및 타격 효과음 재생
