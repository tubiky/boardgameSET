extends Area2D

class_name Advanced_Card


@onready var textureBtn = $TextureButton
@onready var backgroundImage = $Sprite2D

@export_group("Card Values")
@export_enum("Rhombus", "Oval", "Peanut") var figureShape: String = "Oval"
@export_enum("Red", "Green", "Purple") var figureColor: String = "Purple"
@export_enum("Full", "Slash", "Empty") var figureShade: String = "Full"
@export_range(1, 3) var figureQuantity: int = 2


func _init(shp, hue, shd, qt):
	figureShape = shp
	figureColor = hue
	figureShade = shd
	figureQuantity = qt
	
	# textureBtn.texture_normal = load("res://images/cardvalues/"+figureShape+"_"+figureShade+"_"+str(figureQuantity)+".png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
