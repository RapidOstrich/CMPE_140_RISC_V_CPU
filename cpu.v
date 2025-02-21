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
    
    /*----FLAGS----*/
    reg prog_start;    
    
    /*----Wire Connections----*/
    wire imm_sel;
    wire [31:0] mux_result, rs1_value, rs2_value, alu_result;
    wire [11:0] imm_value;
    wire [6:0] funct7, opcode;
    wire [4:0] rd_sel, rs1_sel, rs2_sel;
    wire [2:0] funct3;    
    
    /*----Pipeline Registers----*/
    reg [31:0] instr_fetch;
    
    
    /*----Block Components----*/
    cc_counter ccc(
        .rst_n(rst_n),
        .clk(clk)
        /*----TODO----*/
    );
    
    decoder dcr(
        .instruction(instr_fetch),
        .funct3_out(funct3),
        .funct7_out(funct7),
        .rd_sel_out(rd_sel),
        .rs1_sel_out(rs1_sel),
        .rs2_sel_out(rs2_sel),
        .imm_value_out(imm_value),
        .opcode_out(opcode),
        .imm_sel_out(imm_sel)
    );
    
    mux_alu mux(
        .imm_sel_in(imm_sel),
        .imm_value_in(imm_value),
        .rs2_in(rs2_value),
        .mux_out(mux_result)
    );
    
    alu alu(
        .opcode_in(opcode),
        .funct3_in(funct3),
        .funct7_in(funct7),
        .rs1_in(rs1_value),
        .mux_result_in(mux_result),
        .alu_result_out(alu_result)
    );
    
    register_file rgf(
        .clk(clk),
        .write_enable(/*----TODO----*/),
        .rd_sel_in(rd_sel),
        .rs1_sel_in(rs1_sel),
        .rs2_sel_in(rs2_sel),
        .write_data_in(alu_result),
        .rs1_value_out(rs1_value),
        .rs2_value_out(rs2_value)
    );
    
    /*----FETCH----*/
    always @(posedge clk) begin
        instr_fetch <= imem_insn;
    end
    
    
    
    /*----DECODE----*/
  
endmodule
