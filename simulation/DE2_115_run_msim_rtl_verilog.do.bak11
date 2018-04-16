transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/FIFO {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/FIFO/contr_fifo_send_ram.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/FIFO {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/FIFO/contr_fifo_rec_ram.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/RAM {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/RAM/my_ram.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/FIFO {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/FIFO/my_fifo.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/UART {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/UART/send.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/UART {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/UART/rec.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/main {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/main/uart_top.v}

vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/main {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO14/main/uart_top_tf.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  uart_top_tf

add wave *
view structure
view signals
run -all
