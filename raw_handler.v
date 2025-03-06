`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 03/05/2025 02:07:34 PM
// Design Name: RAW Handler
// Module Name: raw_handler
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: 
// Tool Versions: 
// Description: Read-After-Write handler for pipeline hazard.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module raw_handler(
    input clk,
    input [4:0] rs1_sel_in, rs2_sel_in, rd_write_back_in, rd_write_back_in_2,
    input [31:0] rs1_value_in, rs2_value_in, rd_value_in, rd_wb_value_2,
    output reg [4:0] get_rs1, get_rs2,
    output reg [31:0] rs1_value_out, rs2_value_out    
);

    always @(*) begin
    
        get_rs1 <= rs1_sel_in;
        get_rs2 <= rs2_sel_in;

        if (rs1_sel_in == rd_write_back_in) begin
            rs1_value_out <= rd_value_in;
        end
        
        else if (rs1_sel_in == rd_write_back_in_2) begin
            rs1_value_out <= rd_wb_value_2;
        end
        
        else begin
            rs1_value_out <= rs1_value_in;
        end
        
        if (rs2_sel_in == rd_write_back_in) begin
            rs2_value_out <= rd_value_in;
        end
        
        else if (rs2_sel_in == rd_write_back_in_2) begin
            rs2_value_out <= rd_wb_value_2;
        end        
        
        else begin
            rs2_value_out <= rs2_value_in;
        end

    end

endmodule
