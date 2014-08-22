
# Goal: calculate phi, psi, chi dihedral angles
# Author: Yuhang Wang
# Date: 08/20/2014

package provide CalcDihedral 1.0.0
package require TclOO


# new namespace
namespace eval ::CalcDihedral {
  namespace export FindDihedral
}



oo::class create ::CalcDihedral::FindDihedral {
	variable outputChannel ; # object variable
	variable _4_atom_names
	
	constructor {output_file_name} {
		set outputChannel [open $output_file_name w]
	}
	
	destructor {
		close $outputChannel
	}
	
	##====================== Setter ===========================
	method set_4_atomNames {atom_name1 atom_name2 atom_name3 atom_name4} {
		# instance variables
		set atomName1 $atom_name1
		set atomName2 $atom_name2
		set atomName3 $atom_name3
		set atomName4 $atom_name4
	}
	
	
	##======== Getter ===========
	method get_4_atomNames {} {
		foreach atomName {$atomName1 $atomName2 $atomName3}
		
	}
	
	
	
	
	##========= Setter ==========
	method get_outputFileName {} {
		my variable outputFileName
		puts ">>> OUTPUT FILE NAME: $outputFileName"
		return $outputFileName
	}
	
	

	##======== Functions ==========
	method calc_dihedral {} {
		my variable atomName1 atomName2 atomName3 atomName4 ; # make variables available
		puts "$atomName1 $atomName2 $atomName3 $atomName4"
	}
	
	
	method valid? {val} {
		if {$val} {
			puts "Yes, \"$val\" is valid!"
		} else {
			puts "not valid!"
		}
	}
}




oo::class create fruit {
    method eat {} {
	puts "yummy!"
    }
}
oo::class create banana {
    superclass fruit
    constructor {already_peeled msg} {
	my variable peeled
	set peeled $already_peeled
	puts "$peeled"
    }
    method peel {} {
	my variable peeled
	set peeled 1
	puts "skin now off"
    }
    method edible? {} {
	my variable peeled
	return $peeled
    }
    method eat {} {
	if {![my edible?]} {
	    my peel
	}
	next
    }
}
