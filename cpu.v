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
/*--------Required Ports--------*/
    // Active low reset & Clock
    input rst_n, clk,
    
    // Instruction from Instruction memory
    input [31:0] imem_insn,
    
    // Write enable for data memory
    output dmem_wen,
    
    // Instruction memory address & Data memory address
    output [31:0] imem_addr, dmem_addr,
    
    // Data to & from memory
    inout [31:0] dmem_data,  
    
/*--------Trace Ports--------*/
    output [31:0] trace_instruction, trace_rd_value,
    output [11:0] trace_imm,
    output [4:0] trace_rd, trace_rs1, trace_rs2
);
    
/*--------Wire Connections--------*/
    wire        imm_sel,
                write_enable,
                write_enable_reg,
                write_enable_alu;
    
    wire [31:0] instruction_reg,
                mux_result,
                mux_result_reg,
                rs1_value,
                rs1_value_reg,
                rs2_value,
                rs2_value_reg,
                alu_result,
                alu_result_reg,
                rd_wb_value,
                raw_rs1_value,
                raw_rs2_value;
                
    wire [11:0] imm_value;
    
    wire [6:0]  funct7,
                funct7_reg,
                opcode,
                opcode_reg;
                
    wire [4:0]  rd_sel,
                rd_sel_reg,
                rd_sel_wb,
                rd_write_back,
                rs1_sel,
                rs1_sel_reg,
                rs2_sel,
                rs2_sel_reg,
                get_rs1,
                get_rs2;                
                
    wire [2:0]  funct3,
                funct3_reg;    
    
/*--------Pipeline Registers--------*/

    /*--------Fetch--------*/
    pipeline_reg_instruction pri(
        .clk(clk),
        .instruction_in(imem_insn),
        .instruction_out(instruction_reg),
        
        /*----Trace Debugging----*/        
        .trace_instruction(trace_instruction)
    );
    
    /*--------Decode--------*/
    pipeline_reg_decoder prd(
        .clk(clk),
        .write_enable_in(write_enable),
        .mux_result_in(mux_result),
        .rs1_value_in(raw_rs1_value),
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
    
    /*--------Execute--------*/
    pipeline_reg_alu pra(
        .clk(clk),
        .write_enable_in(write_enable_reg),
        .rd_sel_in(rd_sel_reg),
        .alu_result_in(alu_result),
        .write_enable_out(write_enable_alu),
        .rd_sel_out(rd_sel_wb),
        .alu_result_out(alu_result_reg),
        .rd_write_back_out(rd_write_back),
        .rd_wb_value_out(rd_wb_value)
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
        .program_count(imem_addr)
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
        .rs2_value_in(raw_rs2_value),
        .mux_result_out(mux_result),
        
        /*----Trace Debugging----*/
        .trace_imm(trace_imm)
    );
    
    alu alu(
        .opcode_in(opcode_reg),
        .funct3_in(funct3_reg),
        .funct7_in(funct7_reg),
        .rs1_value_in(rs1_value_reg),
        .mux_result_in(mux_result_reg),
        .alu_result_out(alu_result)
    );
    
    raw_handler rwh(
        .clk(clk),
        .rs1_sel_in(rs1_sel),
        .rs2_sel_in(rs2_sel),
        .rd_write_back_in(rd_write_back),
        .rs1_value_in(rs1_value),
        .rs2_value_in(rs2_value),
        .rd_value_in(rd_wb_value),
        .get_rs1(get_rs1),
        .get_rs2(get_rs2),
        .rs1_value_out(raw_rs1_value),
        .rs2_value_out(raw_rs2_value)
    );
    
    register_file rgf(
        .clk(clk),
        .write_enable_in(write_enable_alu),
        .rd_sel_in(rd_sel_wb),
        .rs1_sel_in(get_rs1),
        .rs2_sel_in(get_rs2),
        .write_data_in(alu_result_reg),
        .rs1_value_out(rs1_value),
        .rs2_value_out(rs2_value),
        
        /*----Trace Debugging----*/
        .trace_rd(trace_rd),
        .trace_rs1(trace_rs1),
        .trace_rs2(trace_rs2),
        .trace_write_in(trace_rd_value) 
    );

endmodule
