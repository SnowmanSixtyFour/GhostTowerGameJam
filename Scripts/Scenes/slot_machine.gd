extends Control

# HUD
@onready var SpinButton = $SpinButton
@onready var AttemptsLabel = $Attempts

# Slot Machine
@onready var MachineHandle = $Handle

var handle = load("res://Assets/Images/GUI/slot_machine_handle.png")
var handle_down = load("res://Assets/Images/GUI/slot_machine_handle_down.png")

# Spinning Slots
@export var n_options: int = 5
@export var spinners: Array[Control]
var values: Array; var tween: Tween

# Variables
var attempts: int = 10

func _ready():
	update_attempts()

func _process(delta: float):
	AudioManager.play_music(Music.slot_machine)

func update_attempts():
	AttemptsLabel.text = "Attempts: " + str(attempts)

func remove_from_attempts(value: int = 1):
	attempts -= value
	update_attempts()

func spin_button():
	if attempts > 0:
		spin()

func spin():
	SpinButton.disabled = true
	
	AudioManager.play_sfx(Sfx.slots_sound)
	MachineHandle.texture = handle_down
	
	remove_from_attempts()
	
	# Spin
	values = []
	var spin_step = 1.0 / float(n_options)
	var offsets = {}
	for s in spinners:
		values.append(randi_range(0, n_options - 1))
		
		var from = s.material.get_shader_parameter('y_offset')
		var to = 3.0 + values[-1] * spin_step
		while to <= from:
			to += 1.0
		
		offsets[s] = { 'from': from, 'to': to }

	if tween: tween.kill()
	tween = get_tree().create_tween()
	tween.tween_method(func (v):
		for s in spinners:
			s.material.set_shader_parameter('y_offset', lerpf(offsets[s].from, offsets[s].to, v)),
		0.0, 1.0, 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(func ():
		for s in spinners:
			s.material.set_shader_parameter('y_offset', offsets[s].to))
	
	# When spin is done
	await get_tree().create_timer(2.0).timeout
	
	SpinButton.disabled = false
	MachineHandle.texture = handle
