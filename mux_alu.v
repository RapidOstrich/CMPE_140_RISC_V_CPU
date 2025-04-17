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
    input           DCR_imm_sel,
    
    input [11:0]    DCR_imm_val,
    
    input [31:0]    RAW_rs2_val,
    
    output [31:0]   MUX_mux_val,
    
/*--------Trace Debugging--------*/
    output [11:0]   TRACE_imm_val   
);

    assign MUX_mux_val = (DCR_imm_sel) ? {{20{DCR_imm_val[11]}}, DCR_imm_val} : RAW_rs2_val;
    
    /*--------Trace Debugging--------*/
    assign TRACE_imm_val = DCR_imm_val;
    
endmodule