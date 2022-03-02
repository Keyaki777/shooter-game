extends Button
signal upgrade_button_pressed(button)
signal upgrade_animation_ended

onready var label_name = $VBoxContainer/Name
onready var label_level = $VBoxContainer/Level
onready var ui_description = $VBoxContainer/Description
onready var label_price = $VBoxContainer/Price
onready var atribute_description = $VBoxContainer/Atribute_descrption
onready var label_bonus_10 = $VBoxContainer/Bonus10
onready var label_bonus_20 = $VBoxContainer/Bonus20
onready var label_bonus_30 = $VBoxContainer/Bonus30

var upgrade: Upgrade


func fill_fields(upgrade: Upgrade) -> void:
	self.upgrade = upgrade
	label_name.text = String(upgrade._up_name)
	label_level.text = "Level: " + String(upgrade.level)
	ui_description.text = "Description: " + String(upgrade._desc_name)
	label_price.text = "Price: " + String(upgrade.price)
	
	if upgrade.is_bonus_10:
		label_bonus_10.text = "UNLOCKED " + String(upgrade._bonus_lv10_descr)
		
	if upgrade.is_bonus_20:
		label_bonus_20.text = "UNLOCKED " + String(upgrade._bonus_lv20_descr)
	
	if upgrade.is_bonus_30:
		label_bonus_30.text = "UNLOCKED " + String(upgrade._bonus_lv30_descr)
	
	if upgrade.is_activated:
		atribute_description.text = String(upgrade._atribute_bonus) + ">" + String(upgrade.check_next_atribute())


func _on_Button_button_up():
	emit_signal("upgrade_button_pressed", self)

func _play_upgrade_animation():
	$AnimationPlayer.play("shine")

func update_fields():
	fill_fields(upgrade)
