# ����������ѹ�����Ż�bit�ļ���С
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

# 32λ����sw������Լ��������

# 32λLED�Ƶ�����Լ��

# ����ܵĶ�ѡ����Լ��
set_property IOSTANDARD LVCMOS18 [get_ports {seg[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {seg[0]}]
set_property PACKAGE_PIN H19 [get_ports {seg[7]}]
set_property PACKAGE_PIN G20 [get_ports {seg[6]}]
set_property PACKAGE_PIN J22 [get_ports {seg[5]}]
set_property PACKAGE_PIN K22 [get_ports {seg[4]}]
set_property PACKAGE_PIN K21 [get_ports {seg[3]}]
set_property PACKAGE_PIN H20 [get_ports {seg[2]}]
set_property PACKAGE_PIN H22 [get_ports {seg[1]}]
set_property PACKAGE_PIN J21 [get_ports {seg[0]}]
# ����ܵ�λѡ��ʹ���źŵ�Լ��
set_property IOSTANDARD LVCMOS18 [get_ports {which[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {which[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {which[0]}]
set_property PACKAGE_PIN N22 [get_ports {which[0]}]
set_property PACKAGE_PIN M21 [get_ports {which[1]}]
set_property PACKAGE_PIN M22 [get_ports {which[2]}]
set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN L21} [get_ports enable]


set_property IOSTANDARD LVCMOS18 [get_ports {SW[31]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[30]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[29]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[28]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[27]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[26]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[25]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[24]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[23]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[22]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[21]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[20]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[19]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[18]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[17]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[16]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[15]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[14]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[13]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[12]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[11]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {SW[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports clk_dm]
set_property IOSTANDARD LVCMOS18 [get_ports rst]

set_property PACKAGE_PIN AB8 [get_ports {SW[0]}]
set_property PACKAGE_PIN AB7 [get_ports {SW[1]}]
set_property PACKAGE_PIN U7 [get_ports {SW[2]}]
set_property PACKAGE_PIN R6 [get_ports {SW[3]}]
set_property PACKAGE_PIN T3 [get_ports {SW[31]}]
set_property PACKAGE_PIN U3 [get_ports {SW[30]}]
set_property PACKAGE_PIN T4 [get_ports {SW[29]}]
set_property PACKAGE_PIN V3 [get_ports {SW[28]}]
set_property PACKAGE_PIN V4 [get_ports {SW[27]}]
set_property PACKAGE_PIN W4 [get_ports {SW[26]}]
set_property PACKAGE_PIN Y4 [get_ports {SW[25]}]
set_property PACKAGE_PIN Y6 [get_ports {SW[24]}]
set_property PACKAGE_PIN W7 [get_ports {SW[23]}]
set_property PACKAGE_PIN Y8 [get_ports {SW[22]}]
set_property PACKAGE_PIN Y7 [get_ports {SW[21]}]
set_property PACKAGE_PIN T1 [get_ports {SW[20]}]
set_property PACKAGE_PIN U1 [get_ports {SW[19]}]
set_property PACKAGE_PIN U2 [get_ports {SW[18]}]
set_property PACKAGE_PIN W1 [get_ports {SW[17]}]
set_property PACKAGE_PIN W2 [get_ports {SW[16]}]
set_property PACKAGE_PIN Y1 [get_ports {SW[15]}]
set_property PACKAGE_PIN AA1 [get_ports {SW[14]}]
set_property PACKAGE_PIN V2 [get_ports {SW[13]}]
set_property PACKAGE_PIN Y2 [get_ports {SW[12]}]
set_property PACKAGE_PIN AB1 [get_ports {SW[11]}]
set_property PACKAGE_PIN AB2 [get_ports {SW[10]}]
set_property PACKAGE_PIN AB3 [get_ports {SW[9]}]
set_property PACKAGE_PIN AB5 [get_ports {SW[8]}]
set_property PACKAGE_PIN AA6 [get_ports {SW[7]}]
set_property PACKAGE_PIN R2 [get_ports {SW[6]}]
set_property PACKAGE_PIN R3 [get_ports {SW[5]}]
set_property PACKAGE_PIN T6 [get_ports {SW[4]}]
set_property PACKAGE_PIN AA4 [get_ports clk_dm]
set_property PACKAGE_PIN R4 [get_ports rst]
set_property PULLDOWN true [get_ports {SW[31]}]
set_property PULLDOWN true [get_ports {SW[30]}]
set_property PULLDOWN true [get_ports {SW[29]}]
set_property PULLDOWN true [get_ports {SW[28]}]
set_property PULLDOWN true [get_ports {SW[27]}]
set_property PULLDOWN true [get_ports {SW[26]}]
set_property PULLDOWN true [get_ports {SW[25]}]
set_property PULLDOWN true [get_ports {SW[24]}]
set_property PULLDOWN true [get_ports {SW[23]}]
set_property PULLDOWN true [get_ports {SW[22]}]
set_property PULLDOWN true [get_ports {SW[21]}]
set_property PULLDOWN true [get_ports {SW[20]}]
set_property PULLDOWN true [get_ports {SW[19]}]
set_property PULLDOWN true [get_ports {SW[18]}]
set_property PULLDOWN true [get_ports {SW[17]}]
set_property PULLDOWN true [get_ports {SW[16]}]
set_property PULLDOWN true [get_ports {SW[15]}]
set_property PULLDOWN true [get_ports {SW[14]}]
set_property PULLDOWN true [get_ports {SW[13]}]
set_property PULLDOWN true [get_ports {SW[12]}]
set_property PULLDOWN true [get_ports {SW[11]}]
set_property PULLDOWN true [get_ports {SW[10]}]
set_property PULLDOWN true [get_ports {SW[9]}]
set_property PULLDOWN true [get_ports {SW[8]}]
set_property PULLDOWN true [get_ports {SW[7]}]
set_property PULLDOWN true [get_ports {SW[6]}]
set_property PULLDOWN true [get_ports {SW[5]}]
set_property PULLDOWN true [get_ports {SW[4]}]
set_property PULLDOWN true [get_ports {SW[3]}]
set_property PULLDOWN true [get_ports {SW[2]}]
set_property PULLDOWN true [get_ports {SW[1]}]
set_property PULLDOWN true [get_ports {SW[0]}]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_dm_IBUF]

set_property PACKAGE_PIN H4 [get_ports clk_20M]
set_property IOSTANDARD LVCMOS18 [get_ports clk_20M]