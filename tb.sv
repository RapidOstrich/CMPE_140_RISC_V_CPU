`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2023 09:55:51 PM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb();
    
    parameter word_size = 32;
    parameter address_size = 32;
    
    reg rst_n, clk;
    
    // Clock generation
    always begin
        #10 clk = ~clk;
    end
    
    initial begin
        rst_n = 0;
        clk = 0;
        #35 rst_n = 1;
    end
    
/*--------Wire Connections--------*/    
    wire [address_size - 1:0]   imem_addr;
    wire [word_size - 1:0]      imem_insn;
    wire [address_size - 1:0]   dmem_addr;
    wire [word_size - 1:0]      dmem_data;
    wire dmem_wen;
    
/*--------Trace Debugging--------*/
    wire [31:0] trace_instruction, trace_rd_value;
    wire [11:0] trace_imm;
    wire [4:0] trace_rd, trace_rs1, trace_rs2;

/*--------Module Instantiations--------*/
    cpu dut(.*);
    
    trace_logger tl(
        .clk(clk),
        .rst_n(rst_n),
        .trace_instruction(trace_instruction),
        .trace_rd(trace_rd),
        .trace_rs1(trace_rs1),
        .trace_rs2(trace_rs2),
        .trace_rd_value(trace_rd_value),
        .trace_imm(trace_imm)
    );
    
    // Change to the file you need
    rom#(
        .addr_width(address_size),
        .data_width(word_size),
        //.init_file("addi_nohazard-1.dat")
        .init_file("addi_hazards.dat")
    )
    imem(
        .addr(imem_addr),
        .data(imem_insn)
    );
    
    ram#(
        .addr_width(address_size),
        .data_width(word_size),
        .init_file(/*"dummy.dat"*/)
    )
    dmem(
        .rst_n(rst_n),
        .clk(clk),
        .wen(dmem_wen),
        .addr(dmem_addr),
        .data(dmem_data)
    );
   
endmodule
