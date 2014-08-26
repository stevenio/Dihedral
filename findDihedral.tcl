# find dihedral angles
# author: Yuhang Wang
# date: 08/25/2014

package provide Dihedral 1.0.0

# new namespace
namespace eval ::Dihedral {
  namespace export getDihedral  
}

#============================================================
# Helper function: an interface to call VMD::measure::dihed
#============================================================
proc ::Dihedral::calc_dihedral {molId list_4_atomIds frame_begin frame_end} {
 if {[llength $list_4_atomIds] != 4 } {
   puts stderr "ERROR HINT: YOU MUST SPECIFY 4 ATOM IDs (you have used $list_4_atomIds ) in your argument)"
 }
 return [::measure dihed $list_4_atomIds first $frame_begin last $frame_end molid $molId ]
}

#============================================================
# Helper function: get the atom index for a given atom
#============================================================
proc ::Dihedral::getAtomIndex {molId resId atomName} {
  set selection "protein and resid $resId and name $atomName"
  set S [atomselect $molId "$selection"]

  if {[$S num] == 0 } {
    puts stderr "ERROR HINT: ZERO ATOM SELECTED BY: $selection"
    exit
  }

  set Id [$S get index]
  $S delete
  return $Id
}

#============================================================
# Helper function: define chi1 dictionary
#============================================================
proc ::Dihedral::defChi1Dict {} {
   ## proc defChi1Dict
   #  return: a dict of defintions of chi1 dihedrals
   set chi1_dict {
        "ARG" {"N" "CA" "CB" "CG"}
        "ASN" {"N" "CA" "CB" "CG"}
        "ASP" {"N" "CA" "CB" "CG"}
        "CYS" {"N" "CA" "CB" "SG"}
        "GLN" {"N" "CA" "CB" "CG"}
        "GLU" {"N" "CA" "CB" "CG"}
        "HIS" {"N" "CA" "CB" "CG"}
        "ILE" {"N" "CA" "CB" "CG1"}
        "LEU" {"N" "CA" "CB" "CG"}
        "LYS" {"N" "CA" "CB" "CG"}
        "MET" {"N" "CA" "CB" "CG"}
        "PHE" {"N" "CA" "CB" "CG"}
        "PRO" {"N" "CA" "CB" "CG"}
        "SER" {"N" "CA" "CB" "OG"}
        "THR" {"N" "CA" "CB" "OG1"}
        "TRP" {"N" "CA" "CB" "CG"}
        "TYR" {"N" "CA" "CB" "CG"}
        "VAL" {"N" "CA" "CB" "CG1"}
  }
  return $chi1_dict
}


#============================================================
# Helper function: define chi2 dictionary
#============================================================
proc ::Dihedral::defChi2Dict {} {
   ## proc defChi2Dict
   #  return: a dict of defintions of chi2 dihedrals
  set chi2_dict {
      "ARG" {"CA" "CB" "CG" "CD"}
      "ASN" {"CA" "CB" "CG" "OD1"}
      "ASP" {"CA" "CB" "CG" "OD1"}
      "GLN" {"CA" "CB" "CG" "CD"}
      "GLU" {"CA" "CB" "CG" "CD"}
      "HIS" {"CA" "CB" "CG" "ND1"}
      "ILE" {"CA" "CB" "CG1" "CD"}
      "LEU" {"CA" "CB" "CG" "CD1"}
      "LYS" {"CA" "CB" "CG" "CD"}
      "MET" {"CA" "CB" "CG" "SD"}
      "PHE" {"CA" "CB" "CG" "CD1"}
      "PRO" {"CA" "CB" "CG" "CD"}
      "TRP" {"CA" "CB" "CG" "CD1"}
      "TYR" {"CA" "CB" "CG" "CD1"}
  }
  return $chi2_dict
}

#============================================================
# Helper function: list residue types that has chi1 dihedral
#============================================================
proc ::Dihedral::residuesHasChi {dihedralType} {
  ## proc ::Dihedral::residuesHasChi
  #  return: a list of amino acids that has chi1 or chi2 dihedral
  #  arguments: 
  #     dihedralType << example: "chi1"
  switch -regexp -- $dihedralType {
      (?i)chi1 { 
                return [dict keys  [::Dihedral::defChi1Dict]]
               }
      (?i)chi2 { 
                return [dict keys  [::Dihedral::defChi2Dict]]
               }
      default  { return {} }
  }
}


#============================================================
# Helper function: Get dihedral atom names
#============================================================
proc ::Dihedral::getDihedralAtomNames {dihedralType resName} {
  ## proc getDihedralAtomNames {dihedralType resName}
  #  return: a list of 4 atom names to be used for selecting atoms of the dihedral
  #  arguments: 
  #    dihedralType << options: "psi" "phi" "chi1" "chi2"
  #    resName      << example: "GLU" (must be 3-letter name)  
  set chi1_dict [::Dihedral::defChi1Dict]
  set chi2_dict [::Dihedral::defChi2Dict]
  switch -regexp -- $dihedralType {
      (?i)phi { return {"C" "N" "CA" "C"}}
      (?i)psi { return {"N" "CA" "C" "N"}}
      (?i)chi1 { 
                 if {[dict exists $chi1_dict $resName]} {
                   return [dict get $chi1_dict $resName]
                 } else {
                   puts stderr "ERROR HINT: residue $resName does not have chi1 dihedral definition!"
                   return "NOT_FOUND_ERROR"
                 }
               }
      (?i)chi2  { 
                  if {[dict exists $chi2_dict $resName]} {
                   return [dict get $chi2_dict $resName]
                  } else {
                   puts stderr "ERROR HINT: residue $resName does not have chi2 dihedral definition!"
                   return "NOT_FOUND_ERROR"
                  }
                }
      default { puts stderr "ERROR HINT: dihedral type not found"; return "NOT_FOUND_ERROR"}
  }
}

#============================================================
# Helper function: Get dihedral atomIds
#============================================================
proc ::Dihedral::getDihedralAtomIds {dihedralType resId} {
  ## proc ::Dihedral::getDihedralAtomIds 
  #  return: a list of 4 numbers (residue ID's)
  #  arguments: 
  #        dihedralType << the type of dihedral angle
  #        resId        << the residue ID of the currently selected residue
  switch -regexp -- $dihedralType {
      (?i)phi  { return [list [expr $resId - 1] $resId $resId $resId]}
      (?i)psi  { return [list $resId $resId $resId [expr $resId + 1]]}
      (?i)chi1 -
      (?i)chi2 { return [list $resId $resId $resId $resId]}
      default { puts stderr "ERROR HINT: dihedral type not found"; return "NOT_FOUND_ERROR"}
  }

}

#======================================================================
# Main function: getDihedral
#======================================================================
proc ::Dihedral::getDihedral {dihedralType molId resId  resName frame_begin frame_end} {
  #--------------------------------------------------------------------------------
  # Exceptions:
  #  if $dihedralType == "chi1" or "chi2" and  this residue does not have chi1 or chi2 defintion 
  #   throw an exception
  switch -regexp -- $dihedralType {
      (?i)chi1  -
      (?i)chi2  {
                  set found [lsearch [::Dihedral::residuesHasChi $dihedralType ] $resName] ;#< return -1 if not found
                  if { $found == -1 }  {
                     puts stderr "ERROR HINT: residue ${resName}${resId} does not have chi1 dihedral"
                     return "NOT_FOUND_ERROR"
                  }
                }
  }
  #--------------------------------------------------------------------------------


  ## 4 atom names
  set _4_atomNames [::Dihedral::getDihedralAtomNames $dihedralType $resName ]

  ## 4 residue IDs
  set _4_resIds [::Dihedral::getDihedralAtomIds $dihedralType $resId]
  
  ## 4 atom IDs
  set _4_atomIds {}
  foreach atomName $_4_atomNames resId $_4_resIds {
    lappend _4_atomIds [::Dihedral::getAtomIndex $molId $resId $atomName]
  }

  return [::Dihedral::calc_dihedral $molId ${_4_atomIds} $frame_begin $frame_end]

}
