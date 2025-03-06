`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 02/20/2025 05:15:28 PM
// Design Name: MUX ALU
// Module Name: mux_alu
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: 
// Tool Versions: 
// Description: 32-bit value input selection for the ALU
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_alu(
    input imm_sel_in,
    input [11:0] imm_value_in,
    input [31:0] rs2_value_in,
    output [31:0] mux_result_out,
    
/*--------Trace Debugging--------*/
    output [11:0] trace_imm    
);

    assign mux_result_out = (imm_sel_in) ? {{20{imm_value_in[11]}}, imm_value_in} : rs2_value_in;
    
    /*--------Trace Debugging--------*/
    assign trace_imm = imm_value_in;
    
endmodule
