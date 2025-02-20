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
    output reg [6:0] opcode,
   /*----Dynamic partition----*/
    output reg [4:0] rd,
    output reg [2:0] funct3,
    output reg [4:0] rs1, rs2,
    output reg [6:0] funct7,
    
   /*----Immediate Register----*/
    output reg [11:0] imm_value
    );
    
    localparam  reg_reg         = 7'b0110011,
                immediate       = 7'b0010011,
                upper_immediate = 7'b0110111,
                store           = 7'b0100011,
                branch          = 7'b1100011,
                jump            = 7'b1101111;
   
   always @(*) begin
        // Set opcode from instruction
        opcode <= instruction[6:0];
        $display("Opcode: %0b", opcode);
        // Decode opcode
        case (opcode)
            /*--[imm 31:20 | rs1 19:15 | funct3 14:12 | rd 11:7 | opcode 6:0]--*/
            immediate: begin
                imm_value <= instruction[31:20];
                rs1 <= instruction[19:15];
                funct3 <= instruction[14:12];
                rd <= instruction[11:7];
                $display("%0b", imm_value);
            end         
        endcase
        
   end         
              
         
    
endmodule
