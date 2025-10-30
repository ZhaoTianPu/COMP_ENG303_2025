# Cadence Genus(TM) Synthesis Solution, Version 18.14-s037_1, built Mar 27 2019 12:19:21

# Date: Thu Oct 30 14:23:39 2025
# Host: ras.ece.northwestern.edu (x86_64 w/Linux 4.18.0-553.79.1.el8_10.x86_64) (8cores*8cpus*1physical cpu*Intel(R) Core(TM) i7-9700 CPU @ 3.00GHz 12288KB)
# OS:   Red Hat Enterprise Linux release 8.10 (Ootpa)

read_hdl ../Q1_ALU.v
set_db library /vol/ece303/genus_tutorial/NangateOpenCellLibrary_typical.lib
set_db lef_library /vol/ece303/genus_tutorial/NangateOpenCellLibrary.lef
elaborate
current_design ALU
current_design Q1_ALU
current_design alu8
read_sdc ../constraints.sdc
syn_generic
report_timing > timing.rpt
report timing -lint
report_area > area.rpt
syn_map
syn_opt
report_timing > timing.rpt
report_area > area.rpt
write_hdl > alu_conv_syn.v
write_hdl > Q1_ALU_syn.v
quit
