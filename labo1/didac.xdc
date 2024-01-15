#horloge
set_property -dict { PACKAGE_PIN R4 IOSTANDARD LVCMOS33 } [get_ports { clk_100mhz_i }]; # Sch=sysclk
#interrupteurs
set_property -dict { PACKAGE_PIN E22 IOSTANDARD LVCMOS12 } [get_ports { sw_i[0] }]; # Sch=sw[0]
set_property -dict { PACKAGE_PIN F21 IOSTANDARD LVCMOS12 } [get_ports { sw_i[1] }]; # Sch=sw[1]
#reset
set_property -dict { PACKAGE_PIN D22 IOSTANDARD LVCMOS12 } [get_ports { rst_i }]; # Sch=btnd
#bouton
set_property -dict { PACKAGE_PIN C22 IOSTANDARD LVCMOS12 } [get_ports { btnl_i }]; #Sch=btnl
set_property -dict { PACKAGE_PIN B22 IOSTANDARD LVCMOS12 } [get_ports { btnc_i }]; #Sch=btnc
set_property -dict { PACKAGE_PIN D14 IOSTANDARD LVCMOS12 } [get_ports { btnr_i }]; #Sch=btnr
set_property -dict { PACKAGE_PIN F15 IOSTANDARD LVCMOS12 } [get_ports { btnu_i }]; #Sch=btnu
#DELs
set_property -dict { PACKAGE_PIN T14 IOSTANDARD LVCMOS25} [get_ports {dels_o[0]}]; # Sch=led[0]
set_property -dict { PACKAGE_PIN T15 IOSTANDARD LVCMOS25} [get_ports {dels_o[1]}]; # Sch=led[1]
set_property -dict { PACKAGE_PIN T16 IOSTANDARD LVCMOS25} [get_ports {dels_o[2]}]; # Sch=led[2]
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS25} [get_ports {dels_o[3]}]; # Sch=led[3]
set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS25} [get_ports {dels_o[4]}]; # Sch=led[4]
set_property -dict { PACKAGE_PIN W16 IOSTANDARD LVCMOS25} [get_ports {dels_o[5]}]; # Sch=led[5]


# Options de configuration de la plaquette
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
