extends HBoxContainer

@export var ingredient_display_array: Array[IngredientDisplay]
var recipe_name: Label

func _ready() -> void:
	recipe_name = $PanelContainer/VBoxContainer/Label

func set_recipe_name(text: String):
	recipe_name.text = text
