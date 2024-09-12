onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib RAM_I_opt

do {wave.do}

view wave
view structure
view signals

do {RAM_I.udo}

run -all

quit -force
