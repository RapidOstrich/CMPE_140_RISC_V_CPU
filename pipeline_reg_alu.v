`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 02/20/2025 04:34:50 PM
// Design Name: RISC-V Pipeline Register
// Module Name: pipeline_reg_alu
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: NA
// Tool Versions: NA
// Description: Pipeline register for the execute stage.
// 
// Dependencies: NA
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipeline_reg_alu(
    input clk,
    input write_enable_in,
    input [4:0] rd_sel_in,
    input [31:0] alu_result_in,
    output reg write_enable_out,
    output reg [4:0] rd_sel_out, rd_write_back_2,
    output reg [31:0] alu_result_out, rd_wb_value_2
);

    always @(posedge clk) begin
        rd_sel_out <= rd_sel_in;
        alu_result_out <= alu_result_in;
        write_enable_out <= write_enable_in;
        rd_write_back_2 <= rd_sel_in;
        rd_wb_value_2 <= alu_result_in;                        
    end

endmodule
