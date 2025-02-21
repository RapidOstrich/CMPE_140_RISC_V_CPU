`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2025 09:31:49 AM
// Design Name: 
// Module Name: cpu
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


module cpu(
    // Active low reset & Clock
    input rst_n, clk,
    
    // Instruction from Instruction memory
    input [31:0] imem_insn,
    
    // Write enable for data memory
    output dmem_wen,
    
    // Instruction memory address & Data memory address
    output [31:0] imem_addr, dmem_addr,
    
    // Data to & from memory
    inout [31:0] dmem_data
);
    
/*--------FLAGS--------*/
  
    
/*--------Wire Connections--------*/
    wire        imm_sel,
                write_enable,
                write_enable_reg;
    
    wire [31:0] instruction,
                instruction_reg,
                mux_result,
                mux_result_reg,
                rs1_value,
                rs1_value_reg,
                rs2_value,
                rs2_value_reg,
                alu_result,
                alu_result_reg;
                
    wire [11:0] imm_value;
    
    wire [6:0]  funct7,
                funct7_reg,
                opcode,
                opcode_reg;
                
    wire [4:0]  rd_sel,
                rd_sel_reg,
                rs1_sel,
                rs1_sel_reg,
                rs2_sel,
                rs2_sel_reg;
                
    wire [2:0]  funct3,
                funct3_reg;    
    
/*--------Pipeline Registers--------*/
    pipeline_reg_instruction pri(
        .clk(clk),
        .instruction_in(instruction),
        .instruction_out(instruction_reg)
    );
    
    pipeline_reg_decoder prd(
        .clk(clk),
        .write_enable_in(write_enable),
        .mux_result_in(mux_result),
        .rs1_value_in(rs1_value),
        .opcode_in(opcode),
        .funct7_in(funct7),
        .rd_sel_in(rd_sel),
        .funct3_in(funct3),
        .write_enable_out(write_enable_reg),
        .mux_result_out(mux_result_reg),
        .rs1_value_out(rs1_value_reg),
        .opcode_out(opcode_reg),
        .funct7_out(funct7_reg),
        .rd_sel_out(rd_sel_reg),
        .funct3_out(funct3_reg)               
    );
    
    pipeline_reg_alu pra(
        .clk(clk),
        .alu_result_in(alu_result),
        .alu_result_out(alu_result_reg)
    );
    
/*--------Block Components--------*/
    cc_counter ccc(
        .rst_n(rst_n),
        .clk(clk),
        .cc_count(/*----TODO----*/)
    );
    
    program_counter pc(
        .clk(clk),
        .rst_n(rst_n),
        .program_count(/*----TODO----*/)
    );
    
    decoder dcr(
        .instruction(instruction_reg),
        .funct3_out(funct3),
        .funct7_out(funct7),
        .rd_sel_out(rd_sel),
        .rs1_sel_out(rs1_sel),
        .rs2_sel_out(rs2_sel),
        .imm_value_out(imm_value),
        .opcode_out(opcode),
        .imm_sel_out(imm_sel),
        .write_enable_out(write_enable)
    );
    
    mux_alu mux(
        .imm_sel_in(imm_sel),
        .imm_value_in(imm_value),
        .rs2_in(rs2_value),
        .mux_out(mux_result)
    );
    
    alu alu(
        .opcode_in(opcode_reg),
        .funct3_in(funct3_reg),
        .funct7_in(funct7_reg),
        .rs1_in(rs1_value_reg),
        .mux_result_in(mux_result_reg),
        .alu_result_out(alu_result_reg)
    );
    
    register_file rgf(
        .clk(clk),
        .write_enable_in(write_enable_reg),
        .rd_sel_in(rd_sel_reg),
        .rs1_sel_in(rs1_sel),
        .rs2_sel_in(rs2_sel),
        .write_data_in(alu_result_reg),
        .rs1_value_out(rs1_value),
        .rs2_value_out(rs2_value)
    );

endmodule
