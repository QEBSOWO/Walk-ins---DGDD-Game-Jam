class_name IngredientDisplay extends HBoxContainer

@onready var name_label = $NameLabel
@onready var texture_rect = $ColorRect/TextureRect

@export var ingredient_name : String # Name of the ingredient in a given recipe
@export var image : Texture # Image to be displayed

func initialize():
	# To be called externally. Makes this display ingredient information
	name_label.text = ingredient_name
	texture_rect.texture = image
