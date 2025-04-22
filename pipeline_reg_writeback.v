`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2025 09:42:02 PM
// Design Name: 
// Module Name: pipeline_reg_writeback
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


module pipeline_reg_writeback(
    input               clk,
                        MEM_wr_en,
                
    input [4:0]         MEM_rd_sel,
    
    input [31:0]        MEM_rd_val,                
            
    output reg          WB_wr_en,
    
    output reg [4:0]    WB_rd_sel,
                        WB_raw_sel,
    
    output reg [31:0]   WB_rd_val,
                        WB_raw_val   
);

    always @(posedge clk) begin
        WB_wr_en    <= MEM_wr_en;
        WB_rd_sel   <= MEM_rd_sel;
        WB_rd_val   <= MEM_rd_val;
        //WB_raw_sel  <= MEM_rd_sel;
        //WB_raw_val  <= MEM_rd_val;
    end
    
    always @(*) begin
        WB_raw_sel  <= MEM_rd_sel;
        WB_raw_val  <= MEM_rd_val;        
    end    

endmodule
