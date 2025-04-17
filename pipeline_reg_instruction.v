`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 02/20/2025 04:34:50 PM
// Design Name: RISC-V Pipeline Register
// Module Name: pipeline_reg_instruction
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: NA
// Tool Versions: NA
// Description: Pipeline register for the fetch stage.
// 
// Dependencies: NA
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipeline_reg_instruction(
    input               clk,
    
    input [31:0]        instr,
    
    output reg [31:0]   IF_ins,
    
/*--------Trace Debugging--------*/    
    output reg [31:0]   TRACE_ins
);

    always @(posedge clk) begin
        IF_ins <= instr;
        
        /*----Trace Debugging----*/
        TRACE_ins <= instr;
    end

endmodule