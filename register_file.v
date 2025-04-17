`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 02/20/2025 04:34:50 PM
// Design Name: RISC-V Register File
// Module Name: register_file
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: NA
// Tool Versions: NA
// Description: The register file for all 32 CPU registers.
// 
// Dependencies: NA
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_file(
    input               clk,
                        WB_wr_en,
                        
    input [4:0]         WB_rd_sel,
                        RAW_rs1_sel,
                        RAW_rs2_sel,
                        
    input [31:0]        WB_rd_val,
    
    output reg [31:0]   RGF_rs1_val,
                        RGF_rs2_val,
    
/*--------Trace Debugging--------*/
    output reg [4:0]    TRACE_rd_sel,
                        TRACE_rs1_sel,
                        TRACE_rs2_sel,
                        
    output reg [31:0]   TRACE_wb_val
);

    /*--Register file: 32 registers, each 32 bits wide--*/
    reg [31:0] registers [0:31];

    /*--Asynchronous read: Read values based on rs1 and rs2 select inputs--*/
    always @(*) begin
        RGF_rs1_val <= (RAW_rs1_sel == 5'b00000) ? 32'b0 : registers[RAW_rs1_sel];
        RGF_rs2_val <= (RAW_rs2_sel == 5'b00000) ? 32'b0 : registers[RAW_rs2_sel];
    end

    /*--Synchronous write: Write data on clock edge if enabled--*/
    always @(posedge clk) begin
        if (WB_wr_en && WB_rd_sel != 5'b00000) registers[WB_rd_sel] <= WB_rd_val;
            
   /*--------Trace Debugging--------*/
        TRACE_rd_sel    <= WB_rd_sel;
        TRACE_rs1_sel   <= RAW_rs1_sel;
        TRACE_rs2_sel   <= RAW_rs2_sel;
        TRACE_wb_val    <= WB_rd_val;   
        
    end

endmodule