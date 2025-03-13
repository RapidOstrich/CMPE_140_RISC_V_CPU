`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 02/20/2025 04:34:50 PM
// Design Name: RISC-V Arithmetic Logic Unit
// Module Name: alu
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: NA
// Tool Versions: NA
// Description: Performs RISC-V ISA arithmetic operations on operands.
// 
// Dependencies: NA
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(
    input [2:0] funct3_in,    
    input [6:0] opcode_in, funct7_in,
    input [31:0] rs1_value_in, mux_result_in,    
    output reg [31:0] alu_result_out, raw_output
);
    
    /*----Switch Cases----*/
    localparam  reg_reg     = 7'b0110011,
                immediate   = 7'b0010011;
                                
    always @(*) begin
        case (opcode_in)
            
            immediate: begin
                case (funct3_in)
                    3'b000: alu_result_out <= rs1_value_in + mux_result_in;
                    3'b001: alu_result_out <= rs1_value_in << mux_result_in[4:0];
                    3'b010: alu_result_out <= ($signed(rs1_value_in) < $signed(mux_result_in)) ? 1 : 0;
                    3'b011: alu_result_out <= (rs1_value_in < mux_result_in) ? 1 : 0;
                    3'b100: alu_result_out <= rs1_value_in ^ mux_result_in;
                    3'b101: begin
                        if (mux_result_in[11:5] == 0) alu_result_out <= rs1_value_in >> mux_result_in[4:0];
                        else alu_result_out <= $signed(rs1_value_in) >>> mux_result_in[4:0];
                    end
                    3'b110: alu_result_out <= rs1_value_in | mux_result_in;
                    3'b111: alu_result_out <= rs1_value_in & mux_result_in;          
                endcase
            end
            
            reg_reg: begin
                /*----TODO----*/
            end
              
            default: begin
                /*----TODO----*/
            end
            
        endcase
        
        raw_output <= alu_result_out;
          
    end        
    
endmodule
