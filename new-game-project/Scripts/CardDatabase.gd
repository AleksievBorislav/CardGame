const FIRE = "fire"
const FEAR = "fear"
const ICE = "ice"
const THUNDER = "thunder"

const ACE = "ace"
const KING = "king"
const QUEEN = "queen"
const JACK = "jack"

const TEN = "ten"
const NINE = "nine"
const EIGHT = "eight"
const SEVEN = "seven"
const SIX = "six"
const FIVE = "five"
const FOUR = "foud"
const THREE = "three"
const TWO = "two"


const CARDS = {
	# Aces (Legendary Beings)
	"Winged dragon of Ra" : [FIRE, ACE],
	"Osyris the sky dragon" : [ICE, ACE],
	"Obelisk the tormentor" : [FEAR, ACE],
	"EXODIA THE FORBIDDEN ONE" : [THUNDER, ACE],

	# Kings (Powerful Warriors & Dragons)
	"Dark Paladin" : [FEAR, KING],
	"Blue eyes white dragon" : [THUNDER, KING],
	"Magician of Black Chaos" : [ICE, KING],
	"Black sage" : [FIRE, KING],

	# Queens (Strong Female Characters & Magic Users)
	"Black magician girl" : [FEAR, QUEEN],
	"Polymerisation" : [ICE, QUEEN],
	"Monster reborn" : [FIRE, QUEEN],
	"Dragon master knight" : [THUNDER, QUEEN],

	# Jacks (Elite Warriors & Summons)
	"Summoning skull" : [THUNDER, JACK],
	"Flaming swordsman" : [FIRE, JACK],
	"BATMAN NA KON" : [FEAR, JACK],
	"Right hand of the forbidden one" : [ICE, JACK],

	# 10s (Powerful Attack Spells)
	"Left leg of the forbidden one" : [FIRE, TEN],
	"Right leg of the forbidden one" : [THUNDER, TEN],
	#"Obelisk the tormentor" : [FEAR, TEN],
	#"Winged dragon of Ra" : [ICE, TEN],
#
	## 9s (Defense & Resilience Cards)
	#"Blue eyes white dragon" : [THUNDER, NINE],
	#"Black sage" : [FIRE, NINE],
	#"Summoning skull" : [FEAR, NINE],
	#"Monster reborn" : [ICE, NINE],
#
	## 8s (Spells & Magic Defense)
	#"Dark Paladin" : [FEAR, EIGHT],
	#"Flaming swordsman" : [FIRE, EIGHT],
	#"Dragon master knight" : [THUNDER, EIGHT],
	#"Polymerisation" : [ICE, EIGHT],
#
	## 7s (Magicians & Tactical Cards)
	#"Magician of Black Chaos" : [FEAR, SEVEN],
	#"Black magician girl" : [ICE, SEVEN],
	#"Obelisk the tormentor" : [THUNDER, SEVEN],
	#"Blue eyes white dragon" : [FIRE, SEVEN],
#
	## 6s (Defensive Creatures & Traps)
	#"Right hand of the forbidden one" : [THUNDER, SIX],
	#"Left leg of the forbidden one" : [FIRE, SIX],
	#"Right leg of the forbidden one" : [ICE, SIX],
	#"EXODIA THE FORBIDDEN ONE" : [FEAR, SIX],
#
	## 5s (Dark Magic Users)
	#"Magician of Black Chaos" : [ICE, FIVE],
	#"Dark Paladin" : [FEAR, FIVE],
	#"Summoning skull" : [THUNDER, FIVE],
	#"Black magician girl" : [FIRE, FIVE],
#
	## 4s (Swordsmen & Battle Masters)
	#"Flaming swordsman" : [FIRE, FOUR],
	#"Black sage" : [FEAR, FOUR],
	#"Blue eyes white dragon" : [THUNDER, FOUR],
	#"Dragon master knight" : [ICE, FOUR],
#
	## 3s (Lesser Summons)
	#"Summoning skull" : [THUNDER, THREE],
	#"Right hand of the forbidden one" : [ICE, THREE],
	#"Obelisk the tormentor" : [FEAR, THREE],
	#"Winged dragon of Ra" : [FIRE, THREE],
#
	## 2s (Smallest Units & Minions)
	#"Left leg of the forbidden one" : [FIRE, TWO],
	#"Right leg of the forbidden one" : [THUNDER, TWO],
	#"EXODIA THE FORBIDDEN ONE" : [FEAR, TWO],
	#"BATMAN NA KON" : [ICE, TWO]
}
