# Goal: Debug and Test this package
# Author: Yuhang Wang
# Date: 08/21/2014


## add extral libraries
set _extra_lib_path "/Scr/scr-test-steven/lib/tcl/packages"
set auto_path [linsert $auto_path 0 $_extra_lib_path]

package require CalcDihedral 
#package require TclOO

namespace import ::CalcDihedral::*


set output_file_name "test_backbone_phi.dat"

FindDihedral create backbonePhi $output_file_name
backbonePhi set_4_atomNames "C" "O" "CA" "N"


set work_dir "/Scr/scr-test-steven/BetP3mer/Trimer/Analysis/mutinf"
cd $work_dir
puts [pwd]