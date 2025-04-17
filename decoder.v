`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 02/20/2025 04:34:50 PM
// Design Name: RISC-V Instruction Decoder
// Module Name: decoder
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: NA
// Tool Versions: NA
// Description: Decodes the 32-bit instruction into it's respective components.
// 
// Dependencies: NA
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder(
    input [31:0] instruction,
    output reg imm_sel_out, write_enable_out,
    output reg [2:0] funct3_out,
    output reg [4:0] rd_sel_out, rs1_sel_out, rs2_sel_out,
    output reg [6:0] funct7_out, opcode_out,
    output reg [11:0] imm_value_out
);
    
    /*--------Switch Cases--------*/
    localparam  reg_reg         = 7'b0110011,
                immediate       = 7'b0010011,
                upper_immediate = 7'b0110111,
                store           = 7'b0100011,
                branch          = 7'b1100011,
                jump            = 7'b1101111;
   
   always @(*) begin
       
        /*----Init Opcode----*/
        opcode_out <= instruction[6:0];
        
        case (opcode_out)
            /*--[imm 31:20 | rs1 19:15 | funct3 14:12 | rd 11:7 | opcode 6:0]--*/
            immediate: begin
                imm_value_out <= instruction[31:20];
                rs1_sel_out <= instruction[19:15];
                funct3_out <= instruction[14:12];
                rd_sel_out <= instruction[11:7];
                imm_sel_out <= 1;
                write_enable_out <= 1;             
            end
            
            reg_reg: begin
                funct7_out <= instruction[31:25];
                rs2_sel_out <= instruction[24:20];
                rs1_sel_out <= instruction[19:15];
                funct3_out <= instruction[14:12];
                rd_sel_out <= instruction[11:7];
                opcode_out <= instruction[6:0];
                imm_sel_out <= 0;
                write_enable_out <= 1;
            end
            
            /*----Remaining Opcodes TODO----*/
            
        endcase
        
   end
    
endmodule
