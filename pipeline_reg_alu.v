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
    input               clk,
                        ID_wr_en,
                        ID_mem_en,
                        ID_mem_wr,
                        ID_stall,
                        
    input [4:0]         ID_rd_sel,
    
    input [31:0]        ID_alu_val,
                        ID_rs2_val,
    
    output reg          EX_wr_en,
                        EX_mem_en,
                        EX_mem_wr,
                        EX_stall,
    
    output reg [4:0]    EX_rd_sel,
                        EX_raw_sel,
                        
    output reg [31:0]   EX_alu_val,
                        EX_raw_val
);

    always @(posedge clk) begin
        EX_wr_en    <= ID_wr_en;
        EX_mem_en   <= ID_mem_en;
        EX_mem_wr   <= ID_mem_wr;
        EX_rd_sel   <= ID_rd_sel;
        EX_alu_val  <= ID_alu_val;
        //EX_raw_sel  <= ID_rd_sel;
        EX_stall    <= ID_stall;
    end
    
    always @(*) begin
        EX_raw_sel  <= ID_rd_sel;
        EX_raw_val  <= ID_alu_val;        
    end

endmodule