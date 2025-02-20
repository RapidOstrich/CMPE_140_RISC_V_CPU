`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2025 09:31:49 AM
// Design Name: 
// Module Name: cpu
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


module cpu(
    // Active low reset & Clock
    input rst_n, clk,
    
    // Instruction from Instruction memory
    input [31:0] imem_insn,
    
    // Write enable for data memory
    output dmem_wen,
    
    // Instruction memory address & Data memory address
    output [31:0] imem_addr, dmem_addr,
    
    // Data to & from memory
    inout [31:0] dmem_data
);
    
        
    wire [11:0] num;
    
    /*----FLAGS----*/
    reg prog_start;    
    
    /*----Pipeline Registers----*/
    reg [31:0] fetch;
    
    /*----Clock Cycle Coutner----*/
    cc_counter pc(rst_n, clk, /*--TODO--*/, /*--TODO--*/);
    
    /*----Decoder----*/
    decoder dc(.instruction(fetch), .imm_value(num) /*OUTPUTS*/);
    
    /*----FETCH----*/
    always @(posedge clk) begin
        fetch <= imem_insn;
        //$display("%0b", num);
    end
    
    /*----DECODE----*/
  
endmodule


