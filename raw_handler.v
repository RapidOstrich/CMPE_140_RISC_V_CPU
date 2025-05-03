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
    input               clk,
                        EX_stall,
                        MEM_stall,

    input [4:0]         DCR_rs1_sel,
                        DCR_rs2_sel,
                        EX_raw_sel,
                        MEM_raw_sel,
                        //WB_raw_sel,
                        
    input [31:0]        RGF_rs1_val,
                        RGF_rs2_val,
                        EX_raw_val,
                        MEM_raw_val,
                        //WB_raw_val,
                        
    output reg          stall,                        
                        
    output reg [4:0]    RAW_rs1_sel,
                        RAW_rs2_sel,
                        
    output reg [31:0]   RAW_rs1_val,
                        RAW_rs2_val    
);

    always @(*) begin
    
        RAW_rs1_sel <= DCR_rs1_sel;
        RAW_rs2_sel <= DCR_rs2_sel;
        
        /*----Precedence of Checking----*/
        /* EX > MEM > WB > (No data hazard) */
        
        if (DCR_rs1_sel == EX_raw_sel && !EX_stall && DCR_rs1_sel != 0 && EX_raw_sel != 0) begin
            RAW_rs1_val <= EX_raw_val;
            stall <= 0;
        end
                    
        else if (DCR_rs1_sel == MEM_raw_sel && !MEM_stall && DCR_rs1_sel != 0 && MEM_raw_sel != 0) begin
            RAW_rs1_val <= 32'd777;
            stall <= 1;
        end            

        else begin
            RAW_rs1_val <= RGF_rs1_val;
            stall <= 0;
        end
        
        if (DCR_rs2_sel == EX_raw_sel && !EX_stall && DCR_rs2_sel != 0 && EX_raw_sel != 0) begin
            RAW_rs2_val <= EX_raw_val;
            stall <= 0;
        end
                    
        else if (DCR_rs2_sel == MEM_raw_sel && !MEM_stall && DCR_rs2_sel != 0 && MEM_raw_sel != 0) begin
            RAW_rs2_val <= 32'd777;      
            stall <= 1; 
        end            
        
        else begin
            RAW_rs2_val <= RGF_rs2_val;
            stall <= 0;
        end            

    end

endmodule
