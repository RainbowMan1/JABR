extends CanvasLayer

signal transition

var fadeTypes = []


# Called when the node enters the scene tree for the first time.
func _ready():
	fadeTypes.append("FadeToNormal")
	fadeTypes.append("FadeToBlack")

#Calls a transition animation to be played
#When fading to black is chosen it will be followed by a fading to normal animation
# 0: plays fade to normal animation
# 1: plays fade to black animation
func transition(fadeMode): 
	self.set_layer(1)
	print_debug("Layer: " + str(self.layer))
	$AnimationPlayer.play(fadeTypes[fadeMode])
	
	self.set_layer(-1)
	
	print_debug("Layer changed")

#If the fade to black animation is played the transition signal will start and be followed up
#by the fade to normal animation
#If the fade to normal animation is played the transition will finish
func _on_AnimationPlayer_animation_finished(anim_name):
	
	print_debug("ANimation is: " + str($AnimationPlayer.playback_active))
	if(anim_name == "FadeToBlack"):
		
		print_debug("emitting signal")
		emit_signal("transition")
		yield(get_tree().create_timer(.5), "timeout")
		$AnimationPlayer.play("FadeToNormal")
	if(anim_name == "FadeToNormal"):
		
		print_debug("Layer: " + str(self.layer))
		print_debug("Done transitioning")
		
		
	
