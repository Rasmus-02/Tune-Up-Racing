extends Node2D
class_name collidable_part

@export var hitbox : CollisionPolygon2D

# Reparent hitbox to car so the characterBody2d can be in charge of physics
func update_hitbox(car):
	if car != null and car.is_in_group("Car") and hitbox != null and hitbox is CollisionPolygon2D:
		hitbox.reparent(car)
