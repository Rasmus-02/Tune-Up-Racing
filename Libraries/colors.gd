extends Node

enum rarity {common, uncommon, rare, epic, legendary}
const common = "common"
const uncommon = "uncommon"
const rare = "rare"
const epic = "epic"
const legendary = "legendary"

var Factory_White = [Color(0.82, 0.8, 0.75), "Factory White", rarity.common] #0
var Sunset_Yellow = [Color(0.93333333730698, 0.81568628549576, 0), "Sunset Yellow", rarity.uncommon] #1
var Cherry_Red = [Color(0.78, 0.08, 0.18), "Cherry Red", rarity.uncommon] #2
var Alligator_Green = [Color(0.44, 0.54, 0.36), "Alligator Green", rarity.uncommon] #3
var Midnight_Purple = [Color(0.15, 0.004, 0.216), "Midnight Purple", rarity.epic] #4
var Iron_Oxide = [Color(0.9, 0.475, 0.295), "Iron Oxide", rarity.uncommon] #5
var Sky_Blue = [Color(0.66, 0.89, 0.93), "Sky Blue", rarity.rare] #6
var Rose_Pink = [Color(1, 0.735, 0.7), "Rose Pink", rarity.rare] #7
var Crimson_Red = [Color(0.55, 0, 0.18), "Crimson Red", rarity.epic] #8
var Bronze_Gold = [Color(0.588, 0.475, 0.333), "Bronze Gold", rarity.common] #9
var Silver = [Color(0.769, 0.769, 0.769), "Silver", rarity.common] #10
var Apple_Green = [Color(0.3, 0.7, 0.2), "Apple Green", rarity.uncommon] #11
var Blueprint_Blue = [Color(0, 0.35, 0.7), "Blueprint Blue", rarity.uncommon] #12
var Night_Blue = [Color(0, 0.25, 0.4), "Night Blue", rarity.common] #13
var Graphite = [Color(0.24, 0.24, 0.24), "Graphite", rarity.common] #14
var Faded_Yellow = [Color(0.82, 0.8, 0.55), "Faded Yellow", rarity.common] #15
var Retro_Teal = [Color(0.47, 0.8, 0.67), "Retro Teal", rarity.uncommon] #16
var Gold = [Color(0.69, 0.604, 0.392), "Gold", rarity.legendary] #17
var Racing_Green = [Color(0, 0.26, 0.145), "Racing Green", rarity.rare] #18
var Amber_Yellow = [Color(1, 0.75, 0), "Amber Yellow", rarity.epic] #19 
var Electric_Blue = [Color(0.1, 0.78, 1), "Electric Blue", rarity.epic] #20
var Lavender = [Color(0.55, 0.35, 0.7), "Lavender", rarity.rare] #21
var Gray = [Color(0.55, 0.55, 0.55), "Gray", rarity.common] #22
var Lava_Orange = [Color(1, 0.35, 0.071), "Lava Orange", rarity.epic] #23
var Red_Clay = [Color(0.75, 0.24, 0.2), "Red Clay", rarity.uncommon] #24
var Hunter_Green = [Color(0.3, 0.35, 0.33), "Hunter Green", rarity.rare] #25
var Frosty_White = [Color(0.87, 0.92, 0.92), "Frosty White", rarity.uncommon] #26


var list = [Factory_White, Sunset_Yellow, Cherry_Red, Alligator_Green, Midnight_Purple, Iron_Oxide, Sky_Blue, 
	Rose_Pink, Crimson_Red, Bronze_Gold, Silver, Apple_Green, Blueprint_Blue, Night_Blue, Graphite, Faded_Yellow,
	Retro_Teal, Gold, Racing_Green, Amber_Yellow, Electric_Blue, Lavender, Gray, Lava_Orange, Red_Clay, Hunter_Green,
	Frosty_White]
