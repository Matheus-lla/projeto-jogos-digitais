extends CanvasLayer

const text = "Oi minha pequena Aianá, minha guerreira. Eu tenho um chamado para você, cada dia que passa as florestas e os animais estão sendo mais acuados, um mal terrível reina sobre essas terras, e você é a única que pode salvar esse mundo. Anhangá, o Deus sombrio pretende controlar a todos com sua escuridão, essa pequena vila é o último refugio de luz em toda floresta, você precisa encontra-lo e derrota-lo, antes que seja tarde demais. Não se preocupe, você vai conseguir, você é a única que consegue. E quando se sentir perdida, seu Cacique deve te orientar."
const TIME = 0.04
const NEXT_SCENE_PATH = "res://maps/map.tscn"

@onready var rich_text_label: RichTextLabel = $PanelContainer/RichTextLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var start_game_btn: Button = $MarginContainer/HBoxContainer/VBoxContainer/start_game_btn

var index = 0
var timer: float

func _ready() -> void:
	PlayerHud.visible = false
	rich_text_label.text = ""
	timer = TIME
	start_game_btn.pressed.connect(_on_start_game_btn_pressed)
	ResourceLoader.load_threaded_request(NEXT_SCENE_PATH)
	
func on_animation_finished(_animation_name: String):
	var next_scene = ResourceLoader.load_threaded_get(NEXT_SCENE_PATH)
	get_tree().change_scene_to_packed(next_scene)
	PlayerHud.visible = true
	
func _process(delta: float) -> void:
	if index >= text.length():
		return

	timer -= delta
	
	if timer <= 0:
		rich_text_label.text += text[index]
		index += 1
		timer = TIME

func _on_start_game_btn_pressed():
	animation_player.play("fade_in")
	animation_player.animation_finished.connect(on_animation_finished)
