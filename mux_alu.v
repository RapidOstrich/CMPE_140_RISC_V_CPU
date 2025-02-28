`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 02/20/2025 04:34:50 PM
// Design Name: RISC-V ALU Input MUX
// Module Name: mux_alu
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: NA
// Tool Versions: NA
// Description: Handles the input selection for the ALU.
// 
// Dependencies: NA
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_alu(
    input imm_sel_in,
    input [11:0] imm_value_in,
    input [31:0] rs2_in,
    output [31:0] mux_result_out
);

    /*----Sign Extenstion Immediate OR rs2----*/
    assign mux_result_out = (imm_sel_in) ? {{20{imm_value_in[11]}}, imm_value_in} : rs2_in;

endmodule
