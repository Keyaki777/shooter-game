extends Node2D

signal upgrade_ended
signal upgrade_connect_request(upgrade)

var hero: Hero setget set_hero

onready var button1: = $ColorRect/Panel/HBoxContainer/Button
onready var upgrade_container = $UpgradeContainer
onready var color_rect = $ColorRect
onready var upgrades_common = $UpgradeContainer/Common.get_children()
var all_upgrades = []

var upgrade_selected1: Upgrade
var upgrade_selected2: Upgrade
var upgrade_selected3: Upgrade


func _ready():
	all_upgrades.append_array(upgrades_common)
	
	for upgrade in all_upgrades:
		upgrade.connect("request_signal_connect", self, "_on_upgrade_request_signal_connect")
	
	for button in $ColorRect/Panel/HBoxContainer.get_children():
		button.connect("upgrade_button_pressed", self, "upgrade_button_pressed")
		button.connect("upgrade_animation_ended", self, "on_upgrade_animation_ended")
	chosse_upgrades()


func chosse_upgrades() -> void:
	for upgrade in all_upgrades:
		if upgrade.is_unlocked :
			button1.fill_fields(upgrade)
			break


func upgrade_button_pressed(button) -> void:
	if !check_if_can_upgrade():
		return
	button.upgrade.buy()
	button._play_upgrade_animation()
#	button.fill_camps(button.upgrade)


func set_hero(new_hero: Hero) -> void:
	hero = new_hero
	for upgrade in all_upgrades:
		upgrade.hero = hero


func check_if_can_upgrade():
	return true


func on_upgrade_animation_ended() -> void:
	emit_signal("upgrade_ended")


func _on_upgrade_request_signal_connect(upgrade: Upgrade) -> void:
	emit_signal("upgrade_connect_request", upgrade)
