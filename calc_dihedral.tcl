
# Goal: calculate phi, psi, chi dihedral angles
# Author: Steven YH Wang
# Date: 08/20/2014

package provide Dihedral 1.0.0
package require TclOO


# new namespace
namespace eval ::Dihedral {
  namespace export FindDihedral FindPhi
}



oo::class create ::Dihedral::FindDihedral {
	variable outputChannel _4_atom_names; # object variable
	
	constructor {output_file_name} {
		set outputChannel [open $output_file_name w]
	}
	
	destructor {
		close $outputChannel
	}
	
	##====================== Setter ===========================
	# define the 4 atoms (for dihedral angle)
	method set_4_atomNames {atom_name1 atom_name2 atom_name3 atom_name4} {
		# instance variables
		set _4_atom_names {}
		lappend _4_atom_names $atom_name1
		lappend _4_atom_names $atom_name2
		lappend _4_atom_names $atom_name3
		lappend _4_atom_names $atom_name4
	}
	
	
	##======== Getter ===========
	method get_4_atomNames {} {
		foreach _atom_name $_4_atom_names {
			puts $_atom_name
		}
		puts [set _4_atom_names]
		puts $_4_atom_names
		
	}
	
	method get_outputChannel {} {
		my variable outputFileName
		puts ">>> OUTPUT CHANNEL: $outputChannel"
		return $outputChannel
	}
	
	


	
}







::oo::class create ::Dihedral::FindPhi {
	superclass ::Dihedral::FindDihedral
	##======== Functions ==========
	method calc_dihedral {} {
		my variable atomName1 atomName2 atomName3 atomName4 ; # make variables available
		puts "$_4_atom_names"
	}
	
}






#=========================================

