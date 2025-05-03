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
    input [2:0]         ID_fn_3,
        
    input [6:0]         ID_opcode,
                        ID_fn_7,
    
    input [31:0]        ID_rs1_val,
                        ID_mux_val,
                            
    output reg [31:0]   ALU_alu_val
);
    
    /*----Switch Cases----*/
    localparam  R_TYPE = 7'b0110011,
                I_TYPE = 7'b0010011,
                LOAD   = 7'b0000011,
                STORE  = 7'b0100011;
                                
    always @(*) begin
        case (ID_opcode)
            
            I_TYPE: begin
                case (ID_fn_3)
                    3'b000: ALU_alu_val = ID_rs1_val + ID_mux_val;
                    3'b001: ALU_alu_val = ID_rs1_val << ID_mux_val[4:0];
                    3'b010: ALU_alu_val = ($signed(ID_rs1_val) < $signed(ID_mux_val)) ? 1 : 0;
                    3'b011: ALU_alu_val = (ID_rs1_val < ID_mux_val) ? 1 : 0;
                    3'b100: ALU_alu_val = ID_rs1_val ^ ID_mux_val;
                    3'b101: begin
                        if (ID_mux_val[11:5] == 0) ALU_alu_val = ID_rs1_val >> ID_mux_val[4:0];
                        else ALU_alu_val = $signed(ID_rs1_val) >>> ID_mux_val[4:0];
                    end
                    3'b110: ALU_alu_val = ID_rs1_val | ID_mux_val;
                    3'b111: ALU_alu_val = ID_rs1_val & ID_mux_val;          
                endcase
            end
            
            R_TYPE: begin
                case (ID_fn_3)
                    3'b000: begin
                        if (ID_fn_7 == 0) ALU_alu_val = ID_rs1_val + ID_mux_val;
                        else ALU_alu_val = ID_rs1_val - ID_mux_val;
                    end
                    3'b001: ALU_alu_val = ID_rs1_val << ID_mux_val[4:0];
                    3'b010: ALU_alu_val = ($signed(ID_rs1_val) < $signed(ID_mux_val)) ? 1 : 0;
                    3'b011: ALU_alu_val = (ID_rs1_val < ID_mux_val) ? 1 : 0;
                    3'b100: ALU_alu_val = ID_rs1_val ^ ID_mux_val;
                    3'b101: begin
                        if (ID_fn_7 == 0) ALU_alu_val = ID_rs1_val >> ID_mux_val[4:0];
                        else ALU_alu_val = $signed(ID_rs1_val) >> $signed(ID_mux_val[4:0]);
                    end
                    3'b110: ALU_alu_val = ID_rs1_val | ID_mux_val;
                    3'b111: ALU_alu_val = ID_rs1_val & ID_mux_val;
                endcase             
            end
              
            LOAD: begin
                ALU_alu_val = ID_rs1_val + ID_mux_val[11:0];
            end
            
            STORE: begin
                ALU_alu_val = ID_rs1_val + ID_mux_val[11:0];
            end
            
        endcase
          
    end        
    
endmodule