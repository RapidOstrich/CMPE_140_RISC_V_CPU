`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 02/20/2025 04:34:50 PM
// Design Name: RISC-V IF_ins Decoder
// Module Name: decoder
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: NA
// Tool Versions: NA
// Description: Decodes the 32-bit IF_ins into it's respective components.
// 
// Dependencies: NA
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder(
    input [31:0]        IF_ins,
    
    output reg          DCR_wr_en,
                        DCR_mem_en,
                        DCR_mem_wr,
                        DCR_imm_sel,
                        
    output reg [2:0]    DCR_fn_3,
    
    output reg [4:0]    DCR_rd_sel,
                        DCR_rs1_sel,
                        DCR_rs2_sel,
                        
    output reg [6:0]    DCR_fn_7,
                        DCR_opcode,
                        
    output reg [11:0]   DCR_imm_val
);
    
    /*--------Switch Cases--------*/
    localparam  R_TYPE = 7'b0110011,
                I_TYPE = 7'b0010011,
                LOAD   = 7'b0000011;
   
   always @(*) begin
       
        /*----Init Opcode----*/
        DCR_opcode <= IF_ins[6:0];
        
        case (DCR_opcode)
            I_TYPE: begin
                DCR_wr_en    <= 1; 
                DCR_mem_en   <= 0;
                DCR_mem_wr   <= 0;
                DCR_imm_sel  <= 1;
                
                DCR_imm_val  <= IF_ins[31:20];
                DCR_rs1_sel  <= IF_ins[19:15];
                DCR_fn_3     <= IF_ins[14:12];
                DCR_rd_sel   <= IF_ins[11:7];
            end
            
            R_TYPE: begin
                DCR_wr_en    <= 1;
                DCR_mem_en   <= 0;
                DCR_mem_wr   <= 0;
                DCR_imm_sel  <= 0;
                
                DCR_fn_7     <= IF_ins[31:25];
                DCR_rs2_sel  <= IF_ins[24:20];
                DCR_rs1_sel  <= IF_ins[19:15];
                DCR_fn_3     <= IF_ins[14:12];
                DCR_rd_sel   <= IF_ins[11:7];
            end
            
            LOAD: begin
                DCR_wr_en    <= 1;
                DCR_mem_en   <= 1;
                DCR_mem_wr   <= 0;
                DCR_imm_sel  <= 1;
                
                DCR_imm_val  <= IF_ins[31:20];
                DCR_rs1_sel  <= IF_ins[19:15];
                DCR_fn_3     <= IF_ins[14:12];
                DCR_rd_sel   <= IF_ins[11:7];                                
            end
            
        endcase
        
   end
    
endmodule