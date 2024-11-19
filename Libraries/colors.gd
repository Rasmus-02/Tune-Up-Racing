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
var Alligator_Green = [Color(0.44, 0.54, 0.36), "Alligator Green", rarity.common] #3
var Midnight_Purple = [Color(0.15, 0.004, 0.216), "Midnight Purple", rarity.epic] #4
var Iron_Oxide = [Color(0.9, 0.475, 0.295), "Iron Oxide", rarity.uncommon] #5
var Sky_Blue = [Color(0.66, 0.89, 0.93), "Sky Blue", rarity.rare] #6
var Rose_Pink = [Color(0.9, 0.725, 0.715), "Rose Pink", rarity.rare] #7
var Crimson_Red = [Color(0.55, 0, 0.18), "Crimson Red", rarity.epic] #8
var Bronze_Gold = [Color(0.588, 0.475, 0.333), "Bronze Gold", rarity.rare] #9
var Silver = [Color(0.769, 0.769, 0.769), "Silver", rarity.uncommon] #9


var list = [Factory_White, Sunset_Yellow, Cherry_Red, Alligator_Green, Midnight_Purple,
	Iron_Oxide, Sky_Blue, Rose_Pink, Crimson_Red, Bronze_Gold]
