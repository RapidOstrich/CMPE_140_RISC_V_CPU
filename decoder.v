`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2025 10:44:40 AM
// Design Name: 
// Module Name: decoder
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


module decoder(

    input [31:0] instruction,
    
   /*----Static partition----*/     
    output reg [6:0] opcode_out,
    
   /*----Dynamic partition----*/
    output reg [2:0] funct3_out,
    output reg [4:0] rd_sel_out, rs1_sel_out, rs2_sel_out,
    output reg [6:0] funct7_out,
    
   /*----Immediate Register----*/
    output reg [11:0] imm_value_out,
    
    /*----MUX Select----*/
    output reg imm_sel_out
);
    
    localparam  reg_reg         = 7'b0110011,
                immediate       = 7'b0010011,
                upper_immediate = 7'b0110111,
                store           = 7'b0100011,
                branch          = 7'b1100011,
                jump            = 7'b1101111;
   
   always @(*) begin
        // Set opcode from instruction
        opcode_out <= instruction[6:0];
        
        // Decode opcode
        case (opcode_out)
            /*--[imm 31:20 | rs1 19:15 | funct3 14:12 | rd 11:7 | opcode 6:0]--*/
            immediate: begin
                imm_value_out <= instruction[31:20];
                rs1_sel_out <= instruction[19:15];
                funct3_out <= instruction[14:12];
                rd_sel_out <= instruction[11:7];
                imm_sel_out <= 1;
            end         
        endcase
        
   end         

endmodule
