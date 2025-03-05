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
    output reg [4:0] rd_sel_out,
    output reg [31:0] alu_result_out,
    /*--------Hazard Signals--------*/
    input [4:0] hazard_rs1_sel_in,
    output reg hazard_raw_out,
    output reg [31:0] hazard_rd_value_out
);

    always @(posedge clk) begin
        rd_sel_out <= rd_sel_in;
        alu_result_out <= alu_result_in;
        write_enable_out <= write_enable_in;
        
        /*--------Hazard Handling--------*/
        hazard_rd_value_out <= alu_result_in;     
        
        if (hazard_rs1_sel_in == rd_sel_in) begin
            hazard_raw_out <= 1;
        end
        else begin
            hazard_raw_out <= 0;
        end                             
    end
   
endmodule
