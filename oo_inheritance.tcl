## Lesson: inheritance
################################################################
## add extral libraries
set _extra_lib_path "/Scr/scr-test-steven/lib/tcl/packages"
set auto_path [linsert $auto_path 0 $_extra_lib_path]
puts $auto_path
################################################################

package require TclOO


oo::class create Character {
	variable State
	
	constructor {name} {
		puts "Character constructor"
		array set State {defense 2 attack 3 hitpoints 5}
		set State(name) $name
	}
	
	method show {} {
		parray State
	}
	
	method defense {attackStrength} {
		puts "Final Attack: $attackStrength"
		if {$attackStrength > $State(defense)} {
			return "Attack $attackStrength > defence $State(defense).\
			    $State(name) is hit!!!"
		} else {
			return "Attack $attackStrength <= defence $State(defense).\
			  $State(name) is safe."
		}
	}
}


oo::class create Warrior {
	superclass Character
	variable State
	constructor {name} {
		puts "Warrior constructor"
		next $name
		incr State(defense) 2
		incr State(attack) 2
	}
}


oo::class create Human {
	variable State
	constructor {name} {
		puts "Human constructor"
		next $name
		incr State(hitpoints) 2
	}
}


oo::class create shield {
	method defense {attackStrength} {
		puts "Shield reduces attack by 2"
		return [next [expr {$attackStrength - 2}]]
		
	}
}


oo::class create dagger {
	method defense {attackStrength} {
		puts "Dagger reduces attack by 1"
		return [next [expr {$attackStrength - 1}]]
	}
	
}


oo::class create HumanWarrior {
	superclass Human Warrior Character
	mixin shield dagger
	variable State
	
	constructor {name} {
		puts "Human Warrior constructor"
	}
}


puts "Create Object"
Warrior create elmer Siegfired

puts "Show object"
elmer show

puts ""
puts "Attack value 8 against a warrior"
puts [elmer defense 8]

puts [pwd]
