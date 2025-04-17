`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 04/15/2025 06:17:03 PM
// Design Name: RISC-V Pipeline Register
// Module Name: pipeline_reg_memory
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: NA
// Tool Versions: NA
// Description: Pipeline register for the memory stage.
// 
// Dependencies: NA
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipeline_reg_memory(
    input               clk,
                        EX_wr_en,
                        EX_mem_en,
                        EX_mem_wr,
            
    input [4:0]         EX_rd_sel,
    
    input [31:0]        EX_alu_val,   

    output reg          MEM_wr_en,
    
    output reg [4:0]    MEM_rd_sel,
                        MEM_raw_sel,
                    
    output reg [31:0]   MEM_alu_val,
                        MEM_raw_val,
                        
    inout [31:0]        dram                                      
);

    always @(posedge clk) begin      
        MEM_wr_en   <= EX_wr_en;
        MEM_rd_sel  <= EX_rd_sel;
        MEM_alu_val <= EX_alu_val;
        //MEM_raw_sel <= EX_rd_sel;
        /*
        if (EX_mem_en && !EX_mem_wr) begin
            MEM_alu_val <= dram[EX_alu_val];
            MEM_raw_val <= dram[EX_alu_val];
        end     
        //else if (EX_mem_en && EX_mem_wr) dram[EX_alu_val] <= ????????
        else begin
            MEM_alu_val <= EX_alu_val;
            MEM_raw_val <= EX_alu_val;
        end
        */           
    end
    
    always @(*) begin       
        MEM_raw_sel <= EX_rd_sel;
        MEM_raw_val <= EX_alu_val;        
    end    

endmodule
