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
	variable outputChannel _4_atoms; # object variable
	
	constructor {output_file_name atomObj_1 atomObj_2 atomObj_3 atomObj_4} {
		set outputChannel [open $output_file_name w]
		# instance variables
		set _4_atoms {}

		lappend _4_atoms $atomObj_1
		lappend _4_atoms $atomObj_2
		lappend _4_atoms $atomObj_3
		lappend _4_atoms $atomObj_4
		
		puts [[lindex $_4_atoms 0] get resname]
		puts $_4_atoms
		puts [[lindex $_4_atoms 1] get resname]
	}
	
	destructor {
		close $outputChannel
	}
	
	##======== Getter ===========
	method get_4_atomNames {} {
		my variable _4_atoms
		puts "--===-"
		puts $_4_atoms
		foreach _atom $_4_atoms {
			puts [[set $_atom] get resname]
		}
		
	}
	
	method get_outputChannel {} {
		my variable outputFileName
		puts ">>> OUTPUT CHANNEL: $outputChannel"
		return $outputChannel
	}
	
}







::oo::class create ::Dihedral::FindPhi {
	superclass ::Dihedral::FindDihedral
	variable ouputChannel _4_atoms atom1 atom2 atom3 atom4
	constructor {output_file_name molId resid_1 resid_2} {
		set atom1 [atomselect $molId "protein and resid ${resid_1} and name C"]
		set atom2 [atomselect $molId "protein and resid ${resid_2} and name N"]
		set atom3 [atomselect $molId "protein and resid ${resid_2} and name CA"]
		set atom4 [atomselect $molId "protein and resid ${resid_2} and name C"]
		puts "!!---------"
		$atom1 get resname
		next $output_file_name $atom1 $atom2 $atom3 $atom4

	}
	##======== Functions ==========
	method calc_dihedral {} {
		puts "calc. dihedral"
		set _atom $atom1
		puts [$_atom get resname]
	}
	
}






#=========================================

