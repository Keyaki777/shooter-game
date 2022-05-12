extends Button
class_name UpgradeButton
signal upgrade_button_pressed(button)
signal upgrade_animation_ended
signal upgrade_animation_started
signal upgrade_animation_finished


onready var label_name = $VBoxContainer/Name
onready var ui_effect = $VBoxContainer/Effect
onready var atribute_description = $VBoxContainer/Atribute_descrption
onready var label_bonus_1 = $VBoxContainer/LabelVBoxContainer/Bonus1
onready var label_bonus_2 = $VBoxContainer/LabelVBoxContainer/Bonus2
onready var label_bonus_3 = $VBoxContainer/LabelVBoxContainer/Bonus3
onready var animation_player :AnimationPlayer = $AnimationPlayer

var upgrade: Upgrade
var index_of_upgrade: int


func _ready():
	animation_player.connect("animation_finished", self, "upgrade_animation_finished")
	animation_player.connect("animation_started", self, "upgrade_animation_started")
	connect("upgrade_animation_started", SignalManager, "upgrade_animation_finished")
	connect("upgrade_animation_started", SignalManager, "upgrade_animation_started")


func upgrade_animation_finished(animation_name: String) -> void:
	emit_signal("upgrade_animation_finished")

func upgrade_animation_started(animation_name: String) -> void:
	emit_signal("upgrade_animation_started")


func fill_fields(upgrade: Upgrade) -> void:
	self.upgrade = upgrade
	label_name.text = String(upgrade._up_name)
	ui_effect.text = "Effect: " + String(upgrade._up_effect)

	if upgrade.is_bonus_1:
		label_bonus_1.text = "UNLOCKED " + String(upgrade._bonus_1)

	if upgrade.is_bonus_2:
		label_bonus_2.text = "UNLOCKED " + String(upgrade._bonus_2)

	if upgrade.is_bonus_3:
		label_bonus_3.text = "UNLOCKED " + String(upgrade._bonus_3)


func clean_button() -> void:
	upgrade = null
	label_name.text = ""
	ui_effect.text = ""
	label_bonus_1.text = ""
	label_bonus_2.text = ""
	label_bonus_3.text = ""


func _on_Button_button_up():
	emit_signal("upgrade_button_pressed", self)


func _play_upgrade_animation():
	$AnimationPlayer.play("shine")


func update_fields():
	fill_fields(upgrade)
