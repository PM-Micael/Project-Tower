extends Node2D

@export var wave_duration: float = 10.0
@export var prep_phase_duration: float = 5.0
@export var round_tier: int = 2 # Placeholder

@onready var wave_countdown: float = wave_duration
@onready var prep_phase_countdown: float = prep_phase_duration

var in_prep_phase: bool

func _physics_process(delta: float) -> void:
	_counter(delta)

func _counter(delta: float):
	if in_prep_phase == false: # Wave countdown
		if wave_countdown > 0.0:
			wave_countdown -= delta
			print("Wave duration: " + str(wave_countdown))
		else:
			wave_countdown = wave_duration
			in_prep_phase = true
		return
	else: # Prep phase countdown
		if prep_phase_countdown > 0.0:
			prep_phase_countdown -= delta
			print("Prep phase: " + str(prep_phase_countdown))
		else:
			prep_phase_countdown = prep_phase_duration
			in_prep_phase = false
