extends Node2D

@export var wave_duration: float = 10.0
@export var prep_phase_duration: float = 5.0
@export var round_tier: int = 2 # Placeholder

var wave_countdown: float = wave_duration
var prep_phase_countdown: float = prep_phase_duration
var in_prep_phase: bool

signal timer_update (title, count)

func _physics_process(delta: float) -> void:
	_counter(delta)

func _counter(delta: float):
	var title: String
	var counter: float
	 
	if in_prep_phase == false: # Wave countdown
		if wave_countdown > 0.0:
			wave_countdown -= delta
			title = "Wave duration"
			counter = wave_countdown
			# print(title + ": " + str(wave_countdown))
		else:
			wave_countdown = wave_duration
			in_prep_phase = true
	else: # Prep phase countdown
		if prep_phase_countdown > 0.0:
			prep_phase_countdown -= delta
			title = "Prep phase"
			counter = prep_phase_countdown
			# print(title + ": " + str(prep_phase_countdown))
		else:
			prep_phase_countdown = prep_phase_duration
			in_prep_phase = false
	
	emit_signal("timer_update", title, counter)
