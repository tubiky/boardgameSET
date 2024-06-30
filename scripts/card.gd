extends Node2D

class_name Card

signal selected

var color: Array[Color] = [Color.FIREBRICK, Color.DARK_GREEN, Color.MEDIUM_PURPLE]

@onready var area2Dnode = Area2D.new()
@onready var collisionShapeNode = CollisionShape2D.new()
@onready var rectangle = RectangleShape2D.new()
@onready var background_image = Sprite2D.new()
@onready var card_image = Sprite2D.new()
@onready var timer = Timer.new()

@export_group("Card Values")
@export_enum("Rhombus", "Oval", "Peanut") var figureShape: String = "Rhombus"
@export_enum("Red", "Green", "Purple") var figureColor: String = "Purple"
@export_enum("Full", "Slash", "Empty") var figureShade: String = "Full"
@export_range(1, 3) var figureQuantity: int = 3

@export_group("Card Status")
@onready var is_selected : bool = false
@onready var is_mouse_over : bool = false



# Called when the node enters the scene tree for the first time.
func _ready():
	background_image.material = ShaderMaterial.new()
	rectangle.size = Vector2(250, 350)
	collisionShapeNode.shape = rectangle
	background_image.texture = GameManager.card_background_image
	card_image.texture = load("res://images/cardvalues/"+figureShape+"_"+figureShade+"_"+str(figureQuantity)+".png")
	
	add_child(timer)
	add_child(background_image)
	add_child(card_image)
	add_child(area2Dnode)
	area2Dnode.add_child(collisionShapeNode)

	area2Dnode.mouse_entered.connect(on_mouse_entered)
	area2Dnode.mouse_exited.connect(on_mouse_exited)
	
	selected.connect(GameManager.on_card_selected.bind(self))

	apply_shader_to_sprite(card_image)

func emit_selected_signal():
	toggle_is_selected()
	set_visible_false()
	toggle_is_area_monitoring()
	selected.emit()


func toggle_is_mouse_over():
	is_mouse_over = !is_mouse_over
	
func toggle_is_selected():
	if !is_selected:
		return
	else: 
		is_selected = !is_selected
		

func set_visible_true():
	if visible:
		return
	else:
		visible = true
		
func set_visible_false():
	if !visible:
		return
	else:
		visible = false


func toggle_is_area_monitoring():
	area2Dnode.monitoring = !area2Dnode.monitoring

func on_mouse_entered():
	if is_mouse_over:
		return
	else:
		toggle_is_mouse_over()
		apply_card_selected_to_background(background_image)
	

func on_mouse_exited():
	if !is_mouse_over:
		return
	else:
		toggle_is_mouse_over()
		apply_card_selected_to_background(background_image)


func _init(shape, hue, shade, quantity):
	figureShape = shape
	figureColor = hue
	figureShade = shade
	figureQuantity = quantity


func _process(_delta):
	pass
	
	
func _input(event):
	if event is InputEventMouseButton:
		if self.is_mouse_over and event.pressed == true and is_selected == false:
			print("CLick")
			toggle_is_selected()
			GameManager.card_selected.emit(self)
			self.visible = false


func apply_card_selected_to_background(sprite: Sprite2D):
	var shader = Shader.new()
	
	if self.is_mouse_over == true:
		shader.code = """
		shader_type canvas_item;

		void fragment() {
			vec4 tex_color = texture(TEXTURE, UV);
			if (tex_color.rgb == vec3(1.0, 1.0, 1.0)) {
				tex_color.rgb = vec3(0.6, 0.4, 0.8);  // MEDIUM_PURPLE
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
				tex_color.rgb = vec3(0.55, 0.0, 0.0);  // FIREBRICK
			}
			COLOR = tex_color;
		}
		"""
		
	var mt = ShaderMaterial.new()
	mt.shader = shader
	sprite.material = mt


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

