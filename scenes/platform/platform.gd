extends Node2D

##################################################
const MOVING_SPEED = 200.0
# 발판 이동 속도

var direction = 1
# 발판 이동 방향. -1: 위, 1: 아래

##################################################
func _physics_process(delta: float) -> void:
	var new_y = global_position.y + direction * MOVING_SPEED * delta
	# 물리 프레임마다 이동할 좌표
	
	if new_y > 1160.0:
		direction = -1
	elif new_y < 440.0:
		direction = 1
	# 이동 제한을 둬서 방향을 바꾸며 상하로 움직이도록 설정
	
	global_position.y = new_y
	# 연산 후 좌표인 new_y 설정
