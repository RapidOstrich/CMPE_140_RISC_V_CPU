`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2025 11:10:02 AM
// Design Name: 
// Module Name: pipeline_reg_instruction
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


module pipeline_reg_instruction(
    input clk,
    input [31:0] instruction_in,
    output reg [31:0] instruction_out
);

    always @(posedge clk) begin
        instruction_out <= instruction_in;
    end

endmodule
