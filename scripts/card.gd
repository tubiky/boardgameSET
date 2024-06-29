extends Node2D

class_name Card

@onready var area2Dnode = Area2D.new()
@onready var collisionShapeNode = CollisionShape2D.new()
@onready var rectangle = RectangleShape2D.new()
@onready var background_image = Sprite2D.new()
@onready var card_image = Sprite2D.new()
var color: Array[Color] = [Color.FIREBRICK, Color.DARK_GREEN, Color.MEDIUM_PURPLE]

@export_group("Card Values")
@export_enum("Rhombus", "Oval", "Peanut") var figureShape: String = "Rhombus"
@export_enum("Red", "Green", "Purple") var figureColor: String = "Purple"
@export_enum("Full", "Slash", "Empty") var figureShade: String = "Full"
@export_range(1, 3) var figureQuantity: int = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	background_image.material = ShaderMaterial.new()
	var neon_border_shader = load("res://shaders/cardFrame.gdshader")
	rectangle.size = Vector2(250, 320)
	collisionShapeNode.shape = rectangle
	background_image.texture = GameManager.card_background_image
	card_image.texture = load("res://images/cardvalues/"+figureShape+"_"+figureShade+"_"+str(figureQuantity)+".png")
	
	add_child(background_image)
	add_child(card_image)
	add_child(area2Dnode)
	area2Dnode.add_child(collisionShapeNode)

	area2Dnode.mouse_entered.connect(on_mouse_entered)
	area2Dnode.mouse_exited.connect(on_mouse_exited)
	 
	
	apply_shader_to_sprite(card_image)


func on_mouse_entered():
	print("What!@?")
	print(self.figureColor, self.figureQuantity, self.figureShade, self.figureShape)
	var shader_material = background_image.material as ShaderMaterial
	shader_material.set_shader_param("neon_color", Color(0.0, 0.0, 1.0, 1.0)) # Set neon blue color
	

func on_mouse_exited():
	print("Mouse exited")
	var shader_material = background_image.material as ShaderMaterial
	shader_material.set_shader_param("neon_color", Color(1.0, 1.0, 1.0, 1.0)) # Reset to white or original color


func _init(shape, hue, shade, quantity):
	figureShape = shape
	figureColor = hue
	figureShade = shade
	figureQuantity = quantity


func _process(_delta):
	pass
	


func apply_shader_to_sprite(sprite: Sprite2D):
	var shader = Shader.new()
	
	if figureColor == "Purple":
		shader.code = """
		shader_type canvas_item;

		void fragment() {
			vec4 tex_color = texture(TEXTURE, UV);
			if (tex_color.rgb == vec3(0.0, 0.0, 0.0)) {
				tex_color.rgb = vec3(0.6, 0.4, 0.8);  // MEDIUM_PURPLE
			}
			COLOR = tex_color;
		}
		"""
		
	elif figureColor == "Red":
		shader.code = """
		shader_type canvas_item;

		void fragment() {
			vec4 tex_color = texture(TEXTURE, UV);
			if (tex_color.rgb == vec3(0.0, 0.0, 0.0)) {
				tex_color.rgb = vec3(0.55, 0.0, 0.0);  // FIREBRICK
			}
			COLOR = tex_color;
		}
		"""
	else:
		shader.code = """
		shader_type canvas_item;

		void fragment() {
			vec4 tex_color = texture(TEXTURE, UV);
			if (tex_color.rgb == vec3(0.0, 0.0, 0.0)) {
				tex_color.rgb = vec3(0, 0.4, 0.0);  // DARK_GREEN
			}
			COLOR = tex_color;
		}
		"""
		
	var mt = ShaderMaterial.new()
	mt.shader = shader
	sprite.material = mt