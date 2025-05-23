extends Camera2D

var shaking := false
func start_shake(duration := 1.0, strength := 10.0):
	if shaking:
		return
	shaking = true
	var timer = 0.0
	var original_offset = offset

	while timer < duration:
		offset = Vector2(
			randf_range(-strength, strength),
			randf_range(-strength, strength)
		)
		await get_tree().create_timer(0.05).timeout
		timer += 0.05

	offset = original_offset
	shaking = false
