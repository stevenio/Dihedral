# Goal: Debug and Test this package
# Author: Steven YH Wang
# Date: 08/21/2014


## add extral libraries
set _extra_lib_path "/Scr/scr-test-steven/lib/tcl/packages"
set auto_path [linsert $auto_path 0 $_extra_lib_path]

package require Dihedral 
#package require TclOO

namespace import ::Dihedral::*


set output_file_name "test_backbone_phi.dat"

FindDihedral create backbonePhi $output_file_name
backbonePhi set_4_atomNames "C" "O" "CA" "N"
backbonePhi get_4_atomNames 

FindPhi create phi "test_phi.dat"




set work_dir "/Scr/scr-test-steven/BetP3mer/Trimer/Analysis/mutinf"
cd $work_dir
puts [pwd]