extends Node2D

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
	
	for button in $ColorRect/Panel/HBoxContainer.get_children():
		button.connect("upgrade_button_pressed", self, "upgrade_button_pressed")
	
	chosse_upgrades()


func chosse_upgrades() -> void:
	for upgrade in all_upgrades:
		if upgrade.is_unlocked :
			button1.fill_camps(upgrade)
			break


func upgrade_button_pressed(button) -> void:
	button.upgrade.level_up()
	button.fill_camps(button.upgrade)


func set_hero(new_hero: Hero) -> void:
	hero = new_hero
	for upgrade in all_upgrades:
		upgrade.hero = hero
