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
    input               clk,
                        IF_wr_en,
                        IF_mem_en,
                        IF_mem_wr,
                        
    input [2:0]         IF_fn_3,
    
    input [4:0]         IF_rd_sel,
    
    input [6:0]         IF_opcode,
                        IF_fn_7,
                        
    input [31:0]        IF_rs1_val,
                        IF_mux_val,
                        
    output reg          ID_wr_en,
                        ID_mem_en,
                        ID_mem_wr,
    
    output reg [2:0]    ID_fn_3,
    
    output reg [4:0]    ID_rd_sel,
                        
    output reg [6:0]    ID_opcode,
                        ID_fn_7,
                        
    output reg [31:0]   ID_rs1_val,
                        ID_mux_val

);
    
    always @(posedge clk) begin
        ID_wr_en    <= IF_wr_en;
        ID_mem_en   <= IF_mem_en;
        ID_mem_wr   <= IF_mem_wr;
        ID_fn_3     <= IF_fn_3;
        ID_rd_sel   <= IF_rd_sel;
        ID_opcode   <= IF_opcode;
        ID_fn_7     <= IF_fn_7;
        ID_rs1_val  <= IF_rs1_val;
        ID_mux_val  <= IF_mux_val;
    end

endmodule