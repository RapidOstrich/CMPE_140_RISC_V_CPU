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
    input write_enable_in,
    input [5:0] rd_sel_in,
    input [31:0] alu_result_in,
    output reg write_enable_out,
    output reg [5:0] rd_sel_out,
    output reg [31:0] alu_result_out,
    
/*--------Trace Debugging--------*/
    output reg [31:0] trace_result    
);

    always @(posedge clk) begin
        rd_sel_out <= rd_sel_in;
        alu_result_out <= alu_result_in;
        
        /*----Trace Debugging----*/
        trace_result <= alu_result_in;
    end

endmodule
