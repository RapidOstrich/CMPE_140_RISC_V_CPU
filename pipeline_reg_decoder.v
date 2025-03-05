`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 02/20/2025 04:34:50 PM
// Design Name: RISC-V Pipeline Register
// Module Name: pipeline_reg_decoder
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: NA
// Tool Versions: NA
// Description: Pipeline register for the decode stage.
// 
// Dependencies: NA
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipeline_reg_decoder(
    input clk,
    input write_enable_in,
    input [31:0] mux_result_in, rs1_value_in,
    input [6:0] opcode_in, funct7_in,
    input [4:0] rd_sel_in,
    input [2:0] funct3_in,
    output reg write_enable_out,
    output reg [31:0] mux_result_out, rs1_value_out,
    output reg [6:0] opcode_out, funct7_out,
    output reg [4:0] rd_sel_out,
    output reg [2:0] funct3_out,
    /*----Hazard Signals----*/
    input hazard_raw_in,
    input [31:0] hazard_rd_value_in
);
    
    always @(posedge clk) begin
        write_enable_out <= write_enable_in;
        mux_result_out <= mux_result_in;
        opcode_out <= opcode_in;
        funct7_out <= funct7_in;
        rd_sel_out <= rd_sel_in;
        funct3_out <= funct3_in;
        
        /*----RAW Hazard----*/
        /*
        1. Check if rs1 is being written in previous instruction
        2. If yes, retrieve value from ALU pipeline register
        3. If no, proceed as normal
        */
        if (hazard_raw_in) begin
            rs1_value_out <= hazard_rd_value_in;
        end
        else begin
            rs1_value_out <= rs1_value_in;
        end        
    end
    
endmodule
