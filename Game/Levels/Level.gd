extends Node2D



onready var hero = $Hero
onready var _upgrade_system = $Upgrade_Handler
onready var _animation_player = $AnimationPlayer
onready var _wave_system = $AnimationPlayer/WaveSystem


func _ready():
	_wave_system.connect("play", self, "on_wave_system_play")
	_upgrade_system.hero = self.hero


func _show_upgrade_ui() -> void:
	_upgrade_system.visible = true


func _hide_upgrade_ui() -> void:
	_upgrade_system.visible = false


func on_wave_system_play_next() -> void:
	pass


func _animation_stop() -> void:
	_animation_player.stop()


func _animation_play() -> void:
	_animation_player.play()

