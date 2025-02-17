extends Node

##################################################
const FIRE_SOUND = preload("res://sounds/maou_se_8bit17.wav")
const HIT_SOUND = preload("res://sounds/maou_se_8bit28.wav")
# 효과음 두 가지 미리 불러오기
const BGM = preload("res://sounds/Super Gunner.wav")
# 배경 음악 미리 불러오기

var effect_sound_player: AudioStreamPlayer
# 효과음 AudioStreamPlayer 선언
var bgm_sound_player: AudioStreamPlayer
# 배경 음악 AudioStreamPlayer 선언

##################################################
func _ready() -> void:
	effect_sound_player = AudioStreamPlayer.new()
	add_child(effect_sound_player)
	effect_sound_player.volume_db = -10.0
	# effect_sound_player 변수 노드 추가 및 설정
	
	bgm_sound_player = AudioStreamPlayer.new()
	add_child(bgm_sound_player)
	bgm_sound_player.volume_db = -10.0
	bgm_sound_player.stream = BGM
	bgm_sound_player.play()
	# bgm_sound_player 변수 노드 추가 및 설정
	# 재생. Import 설정에서 Forward로 무한 반복 되도록 설정

##################################################
func fire_sound_play() -> void:
# 총알 발사 소리 재생 함수
	effect_sound_player.stream = FIRE_SOUND
	effect_sound_player.play()
	# stream 설정 후 재생

##################################################
func hit_sound_play() -> void:
# 총알 타격 소리 재생 함수
	effect_sound_player.stream = HIT_SOUND
	effect_sound_player.play()
	# stream 설정 후 재생
