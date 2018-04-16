transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10 {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10/uart_transfer.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10 {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10/uart_receiver.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10 {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10/uart_fifo_design.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10 {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10/system_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10 {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10/key_scan.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10 {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10/fifo_uart.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10 {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10/fifo_read_write.v}
vlog -vlog01compat -work work +incdir+C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10 {C:/Users/user/Documents/Fpga/WORKPLACE/DE2_115_RS232FIFO10/clk_generator.v}

