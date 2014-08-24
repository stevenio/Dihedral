set molId [mol new "test.pdb"]
puts "molId $molId"


## add extral libraries
set _extra_lib_path "/Scr/scr-test-steven/lib/tcl/packages"
set auto_path [linsert $auto_path 0 $_extra_lib_path]

package require Dihedral 
#package require TclOO

namespace import ::Dihedral::*


set output_file_name "test_backbone_phi.dat"


set resid_1 100
set resid_2 101
FindPhi create phiObj $output_file_name $molId $resid_1 $resid_2

phiObj calc_dihedral
phiObj get_outputChannel
phiObj destroy
exit
