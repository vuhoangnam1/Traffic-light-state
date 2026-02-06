vsim -voptargs="+acc=2" work.tb_traffic
add wave  \
sim:/tb_traffic/clk \
sim:/tb_traffic/rst \
sim:/tb_traffic/current_light_o \
sim:/tb_traffic/next_light_o \
sim:/tb_traffic/count \
vsim -coverage -gui work.tb_traffic
run -all
coverage report -summary
coverage report -codeAll -details
coverage report -cvg -verbose
