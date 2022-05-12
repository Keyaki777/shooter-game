extends Node2D





var current_state: int = 0 setget set_current_state
enum {BUY, UPGRADE}

var hero: Hero setget set_hero

onready var button1: = $ColorRect/Panel/ButtonsHBoxContainer/Button
onready var all_buttons = $ColorRect/Panel/ButtonsHBoxContainer.get_children()
onready var upgrade_container = $UpgradeContainer
onready var color_rect = $ColorRect
onready var unsorted_container = $UpgradeContainer/UnsortedContainer.get_children()
var all_upgrades = []
var non_bought_upgrades: Array
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var upgrade_selected1: Upgrade
var upgrade_selected2: Upgrade
var upgrade_selected3: Upgrade


func _ready():
	rng.randomize()
	all_upgrades.append_array(unsorted_container)
	non_bought_upgrades = all_upgrades
	set_containers()

	for button in $ColorRect/Panel/ButtonsHBoxContainer.get_children():
		button.connect("upgrade_button_pressed", self, "upgrade_button_pressed")
		button.connect("upgrade_animation_ended", self, "on_upgrade_animation_ended")
	chosse_upgrades_to_buy()
#	chosse_upgrades_to_upgrade()


func chosse_upgrades_to_buy() -> void:
	set_current_state(BUY)
	for button in all_buttons:
		var this_button: UpgradeButton = button
		this_button.clean_button()
	
	
	var buttons_filled: int = 0
	while buttons_filled < 3:
		var random_upgrade_index = rng.randi_range(0, non_bought_upgrades.size()-1)
		var this_upgrade = non_bought_upgrades[random_upgrade_index]
		if this_upgrade.is_unlocked and !this_upgrade.is_activated:
			if !is_upgrade_in_button(this_upgrade):
				all_buttons[buttons_filled].fill_fields(this_upgrade)
				all_buttons[buttons_filled].index_of_upgrade = buttons_filled
				buttons_filled += 1
				
	
	
	
	
	
#	var buttons_filled : int = 0
#	for upgrade in all_upgrades:
#		var this_upgrade: Upgrade = upgrade
#		if this_upgrade.is_unlocked and !this_upgrade.is_activated:
##			button1.fill_fields(upgrade)
#			if is_upgrade_in_button(this_upgrade):
#				continue
#			all_buttons[buttons_filled].fill_fields(this_upgrade)
#			buttons_filled += 1
#			if buttons_filled == 3:
#				break
#
	

func is_upgrade_in_button(upgrade) -> bool:
	var upgrade_already_used: bool = false
	for button in all_buttons:
		var this_upgrade_button: UpgradeButton = button
		if upgrade == this_upgrade_button.upgrade:
			upgrade_already_used = true
	
	return upgrade_already_used



func chosse_upgrades_to_upgrade() -> void:
	set_current_state(UPGRADE)
	
	for button in all_buttons:
		var this_button: UpgradeButton = button
		this_button.clean_button()
	
	var buttons_filled : int = 0
	for upgrade in all_upgrades:
		var this_upgrade: Upgrade = upgrade
		if this_upgrade.is_unlocked and this_upgrade.is_activated:
			if is_upgrade_in_button(this_upgrade):
				continue
			all_buttons[buttons_filled].fill_fields(this_upgrade)
			buttons_filled += 1


func unlock_unique_secondary_upgrades(type: String) -> void:
#	var unique_container = upgrade_container.get_node(upgrade.Unique_Types.keys()[upgrade.unique_type])
	var type_container = upgrade_container.get_node(type)
	var upgrades_to_unlock = type_container.get_children()
	for upgrade in upgrades_to_unlock:
		upgrade.is_unlocked = true


func upgrade_button_pressed(button) -> void:
	match current_state:
		UPGRADE:
			awaken_upgrade_clicked(button)
		BUY:
			buy_upgrade_clicked(button)
	
#	button.fill_camps(button.upgrade)


func awaken_upgrade_clicked(button) -> void:
	if !check_if_can_upgrade():
		return
	button.upgrade.awaken()
	button._play_upgrade_animation()



func buy_upgrade_clicked(button) -> void:
	if !check_if_can_upgrade():
		return
	button.upgrade.buy()
	button._play_upgrade_animation()


func set_hero(new_hero: Hero) -> void:
	hero = new_hero
	for upgrade in all_upgrades:
		upgrade.hero = hero


func check_if_can_upgrade():
	return true


func set_containers() -> void:
	for upgrade in all_upgrades:
		upgrade.get_parent().remove_child(upgrade)
		if !upgrade_container.has_node(upgrade.Unique_Types.keys()[upgrade.unique_type]):
			var new_unique_container = Node.new()
			new_unique_container.name = upgrade.Unique_Types.keys()[upgrade.unique_type]
			upgrade_container.add_child(new_unique_container)
			new_unique_container.add_child(upgrade)
		else:
			var unique_container = upgrade_container.get_node(upgrade.Unique_Types.keys()[upgrade.unique_type])
			unique_container.add_child(upgrade)


func _on_upgrade_unlock_secondary(type: String) -> void:
	unlock_unique_secondary_upgrades(type)


func set_current_state(new_value) -> void:
	current_state = new_value
	

func _unhandled_input(event):
	if event:
		pass
