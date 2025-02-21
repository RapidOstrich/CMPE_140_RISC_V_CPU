`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2025 11:05:43 AM
// Design Name: 
// Module Name: pipeline_reg_alu
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


module pipeline_reg_alu(
    input clk,
    input [31:0] alu_result_in,
    output reg [31:0] alu_result_out
);

    always @(posedge clk) begin
        alu_result_out <= alu_result_in;
    end

endmodule
