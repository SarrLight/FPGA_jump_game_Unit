set_property -dict {PACKAGE_PIN N21 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {o_r[0]}]
set_property -dict {PACKAGE_PIN N22 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {o_r[1]}]
set_property -dict {PACKAGE_PIN R21 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {o_r[2]}]
set_property -dict {PACKAGE_PIN P21 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {o_r[3]}]
set_property -dict {PACKAGE_PIN R22 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {o_g[0]}]
set_property -dict {PACKAGE_PIN R23 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {o_g[1]}]
set_property -dict {PACKAGE_PIN T24 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {o_g[2]}]
set_property -dict {PACKAGE_PIN T25 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {o_g[3]}]
set_property -dict {PACKAGE_PIN T20 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {o_b[0]}]
set_property -dict {PACKAGE_PIN R20 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {o_b[1]}]
set_property -dict {PACKAGE_PIN T22 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {o_b[2]}]
set_property -dict {PACKAGE_PIN T23 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {o_b[3]}]
set_property -dict {PACKAGE_PIN M21 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports o_vs]
set_property -dict {PACKAGE_PIN M22 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports o_hs]

# Main clock
set_property PACKAGE_PIN AC18 [get_ports clk]
set_property IOSTANDARD LVCMOS18 [get_ports clk]

# Switches as inputs
#      SW[9]  SW[8]  SW[7]      SW[6]   SW[5]        SW[4]        SW[3]        SW[2]        SW[1]       SW[0]
#      AE12   AE10   AD10       AD11    Y12          Y13          AA12          AA13         AB10        AA10
set_property PACKAGE_PIN AD10 [get_ports i_bt]
set_property PACKAGE_PIN AE12 [get_ports rst]

set_property IOSTANDARD LVCMOS15 [get_ports i_bt]
set_property IOSTANDARD LVCMOS15 [get_ports rst]

set_property PACKAGE_PIN AF25 [get_ports o_buzzer]
set_property IOSTANDARD LVCMOS33 [get_ports o_buzzer]

# Arduino-Segment & AN
set_property PACKAGE_PIN AD21 [get_ports {o_segment_an[0]}]
set_property PACKAGE_PIN AC21 [get_ports {o_segment_an[1]}]
set_property PACKAGE_PIN AB21 [get_ports {o_segment_an[2]}]
set_property PACKAGE_PIN AC22 [get_ports {o_segment_an[3]}]
set_property PACKAGE_PIN AB22 [get_ports {o_segment[0]}]
set_property PACKAGE_PIN AD24 [get_ports {o_segment[1]}]
set_property PACKAGE_PIN AD23 [get_ports {o_segment[2]}]
set_property PACKAGE_PIN Y21 [get_ports {o_segment[3]}]
set_property PACKAGE_PIN W20 [get_ports {o_segment[4]}]
set_property PACKAGE_PIN AC24 [get_ports {o_segment[5]}]
set_property PACKAGE_PIN AC23 [get_ports {o_segment[6]}]
set_property PACKAGE_PIN AA22 [get_ports {o_segment[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_segment_an[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_segment_an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_segment_an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_segment_an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_segment[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_segment[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_segment[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_segment[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_segment[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_segment[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_segment[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_segment[7]}]



