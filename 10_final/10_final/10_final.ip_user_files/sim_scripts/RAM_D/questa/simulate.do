onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib RAM_D_opt

do {wave.do}

view wave
view structure
view signals

do {RAM_D.udo}

run -all

quit -force
