class_name ServeStation extends Station

var Salad = load("res://Gameworld/Scenes/salad.tscn")
var salad_ingredients = ["Berries", "Moss", "Oil"]
var Stew = load("res://Gameworld/Scenes/stew.tscn")
var stew_ingredients = ["Pot", "Spice", "Crab", "Water", "Water"]
var Sandwich = load("res://Gameworld/Scenes/sandwich.tscn")
var sandwich_ingredients = ["Bread", "Slime"]
var order_list: Array[String] # All orders for player to complete in Strings
var player: Player
var player_HUD: CanvasLayer
var recipe_container: HBoxContainer
var recipe_tab = load("res://Character/Scenes/recipe_display.tscn")
var ingredient_entry = load("res://Character/Scenes/ingredient_display.tscn")
var ingredient_icons: Dictionary = {
	"Berries" = "res://Assets/UI/Icons/berries_item.png",
	"Moss" = "res://Assets/UI/Icons/moss_item.png",
	"Oil" = "res://Assets/UI/Icons/olive_oil.png",
	"Pot" = "res://Assets/UI/Icons/pot_item.png",
	"Spice" = "res://Assets/UI/Icons/spices_item.png",
	"Crab" = "res://Assets/UI/Icons/crab_item.png",
	"Water" = "res://Assets/UI/Icons/glass.png",
	"Bread" = "res://Assets/UI/Icons/bread_item.png",
	"Slime" = "res://Assets/UI/Icons/slime.png"
}

signal all_orders_complete

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().root.get_child(0).find_child("Character")
	player_HUD = player.find_child("PlayerHUD")
	recipe_container = player_HUD.find_child("RecipeContainer")

func add_order(new_order: String):
	order_list.append(new_order)
	create_new_order_tab(new_order)
	
func interact(player_area: Area3D):
	var held_dish = player_area.holding
	if held_dish:
		if held_dish in order_list:
			order_list.pop_at(order_list.find(held_dish))
	
	if order_list.is_empty():
		all_orders_complete.emit()

func create_new_order_tab(order: String):
	var new_tab = recipe_tab.instantiate()
	recipe_container.add_child(new_tab)
	new_tab.set_recipe_name(order)
	
	var v_container = new_tab.get_child(0).get_child(0)
	if order == "Salad":
		for ingred in salad_ingredients:
			var new_ingredient = ingredient_entry.instantiate()
			v_container.add_child(new_ingredient)
			new_ingredient.ingredient_name = ingred
			new_ingredient.image = load(ingredient_icons[ingred])
			new_ingredient.initialize()
	if order == "Stew":
		for ingred in stew_ingredients:
			var new_ingredient = ingredient_entry.instantiate()
			v_container.add_child(new_ingredient)
			new_ingredient.ingredient_name = ingred
			new_ingredient.image = load(ingredient_icons[ingred])
			new_ingredient.initialize()
	if order == "Sandwich":
		for ingred in sandwich_ingredients:
			var new_ingredient = ingredient_entry.instantiate()
			v_container.add_child(new_ingredient)
			new_ingredient.ingredient_name = ingred
			new_ingredient.image = load(ingredient_icons[ingred])
			new_ingredient.initialize()
			
