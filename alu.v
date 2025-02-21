`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2025 04:34:50 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input [6:0] opcode_in, funct7_in,
    input [2:0] funct3_in,
    input [31:0] rs1_value_in, mux_result_in,    
    output reg [31:0] alu_result_out
);

    localparam  reg_reg     = 7'b0110011,
                immediate   = 7'b0010011;
                                
    always @(*) begin
        // Reg-Reg or Immediate
        case (opcode_in)
            immediate: begin
                case (funct3_in)
                    3'b000: alu_result_out <= rs1_value_in + mux_result_in;
                  //3'b001: // Shift Left Logical Imm
                  //3'b010: // Set Less Than Imm
                  //3'b011: // Set Less Than Imm (U)
                    3'b100: alu_result_out <= rs1_value_in ^ mux_result_in;
                    3'b101: begin
                        //if (funct7_in[11:5] == 2'h00)
                        //else
                    end
                    3'b110: alu_result_out <= rs1_value_in | mux_result_in;
                    3'b111: alu_result_out <= rs1_value_in & mux_result_in;          
                endcase
            end
            
            reg_reg: begin
                // TODO
            end
              
            default: begin
                // TODO
            end   
        endcase  
    end        
    
endmodule
