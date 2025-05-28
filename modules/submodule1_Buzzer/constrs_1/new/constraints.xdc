set_property PACKAGE_PIN AF25 [get_ports o_buzzer]
set_property IOSTANDARD LVCMOS33 [get_ports o_buzzer]

# Main clock
set_property PACKAGE_PIN AC18 [get_ports clk]
set_property IOSTANDARD LVCMOS18 [get_ports clk]

set_property PACKAGE_PIN AF10 [get_ports rst_n]
set_property PACKAGE_PIN AA10 [get_ports {i_music_scale[0]}]
set_property PACKAGE_PIN AB10 [get_ports {i_music_scale[1]}]
set_property PACKAGE_PIN AA13 [get_ports {i_music_scale[2]}]
set_property PACKAGE_PIN AA12 [get_ports {i_music_scale[3]}]
set_property PACKAGE_PIN Y13 [get_ports {i_music_scale[4]}]
set_property PACKAGE_PIN Y12 [get_ports {i_music_scale[5]}]

set_property IOSTANDARD LVCMOS15 [get_ports rst_n]
set_property IOSTANDARD LVCMOS15 [get_ports {i_music_scale[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {i_music_scale[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {i_music_scale[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {i_music_scale[3]}]
set_property IOSTANDARD LVCMOS15 [get_ports {i_music_scale[4]}]
set_property IOSTANDARD LVCMOS15 [get_ports {i_music_scale[5]}]
