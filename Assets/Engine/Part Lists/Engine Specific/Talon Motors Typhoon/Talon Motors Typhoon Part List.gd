extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String

#Engine ID
var id = 1

#Block
var stock_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Block/Typhoon cast iron block.tscn") #1
var aluminium_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Block/Typhoon aluminium block.tscn") #2
var heavy_duty_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Block/Typhoon heavy duty block.tscn") #3
var billet_aluminium_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Block/Typhoon billet aluminium block.tscn") #4
var block = [empty, stock_block, aluminium_block, heavy_duty_block, billet_aluminium_block]


#Internals
var stock_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon Stock internals.tscn") #1
var stock_high = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon high compression internals.tscn") #2
var stock_low = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon low compression internals.tscn") #3
var forged = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon Forged internals.tscn") #4
var forged_high = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon Forged high compression internals.tscn") #5
var forged_low = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon Forged low compression internals.tscn") #6
var low_friction = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon Low Friction internals.tscn") #7
var low_friction_high = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon Low Friction high compression internals.tscn") #8
var low_friction_low = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon Low Friction low compression internals.tscn") #9
var titanium = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon Titanium internals.tscn") #10
var titanium_high = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon Titanium high compression internals.tscn") #11
var titanium_low = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon Titanium low compression internals.tscn") #12
var internals = [empty, stock_internals, stock_high, stock_low, forged, forged_high, forged_low,
	low_friction, low_friction_high, low_friction_low, titanium, titanium_high, titanium_low]


#Top
var stock_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Top/Typhoon stock top.tscn") #1
var sport_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Top/Typhoon sport top.tscn") #2
var vortex_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Top/Typhoon [vortex] Top.tscn") #3
var redline_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Top/Typhoon [Redline] Top.tscn") #4
var satetsu_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Top/Typhoon [Satetsu] Top.tscn") #5
var ks_racing_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Top/Typhoon [KS-Racing] Top.tscn") #6
var top = [empty, stock_top, sport_top, vortex_top, redline_top, satetsu_top, ks_racing_top]


#Intake manifold
var stock_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Intake Manifold/Typhoon Stock intake manifold.tscn") #1
var efi_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Intake Manifold/Typhoon EFI intake manifold.tscn")#2
var vortex_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Intake Manifold/Typhoon [Vortex] intake manifold.tscn") #3
var stock_supercharger = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Intake Manifold/Typhoon Stock Supercharger intake manifold.tscn")#4
var satetsu_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Intake Manifold/Typhoon [Satetsu] intake manifold.tscn") # 5
var redline_supercharger = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Intake Manifold/Typhoon [Redline] Supercharger intake manifold.tscn") #6
var intake_manifold = [empty, stock_intake_manifold, efi_intake_manifold, vortex_intake_manifold, stock_supercharger, satetsu_intake_manifold, redline_supercharger]


#Exhaust manifold
var stock_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Exhaust Manifold/Typhoon stock exhaust manifold.tscn") #1
var modern_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Exhaust Manifold/Typhoon modern exhaust manifold.tscn") #2
var vortex_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Exhaust Manifold/Typhoon [Vortex] exhaust manifold.tscn") #3
var niepa_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Exhaust Manifold/Typhoon [Niepa] exhaust manifold.tscn") #4
var vortex_60mm_twin_turbo = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Exhaust Manifold/Typhoon [Vortex] 60mm twin turbo.tscn") #5
var redline_70mm_twin_turbo = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Exhaust Manifold/Typhoon [Redline] 70mm twin turbo.tscn") #6
var exhaust_manifold = [empty, stock_exhaust_manifold, modern_exhaust_manifold, vortex_exhaust_manifold, niepa_exhaust_manifold, vortex_60mm_twin_turbo, redline_70mm_twin_turbo]


