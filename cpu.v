`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 02/20/2025 09:31:49 AM
// Design Name: RISC-V CPU
// Module Name: cpu
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: 
// Tool Versions: 
// Description: Top level module for CPU.
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
    input           rst_n,
                    clk,
    
    // Instruction from Instruction memory
    input [31:0]    imem_insn,
    
    // Write enable for data memory
    output          dmem_wen,
    
    // Byte selection for stores
    output [3:0]    byte_en,
    
    // Instruction memory address & Data memory address
    output [31:0]   imem_addr,
                    dmem_addr,
    
    // Data to & from memory
    inout [31:0]    dmem_data,  
    
/*--------Trace Ports--------*/
    output [4:0]    trace_rd,
                    trace_rs1,
                    trace_rs2,
                    
    output [11:0]   trace_imm,
        
    output [31:0]   trace_instruction,
                    trace_rd_value 
);
    wire stall, ID_stall, EX_stall, MEM_stall;

    cc_counter ccc(
        // Inputs
        .clk            (clk),
        .rst_n          (rst_n),
        // Outputs
        .cc_count       (/*----TODO----*/)
    );
    
    program_counter pc(
        // Inputs
        .clk            (clk),
        .rst_n          (rst_n),
        .stall          (stall),
        // Outputs
        .program_count  (imem_addr)
    );

/*----------------Instruction Fetch----------------*/

    wire [31:0] IF_ins;

    pipeline_reg_instruction pri(
        // Inputs
        .clk            (clk),
        .stall          (stall),
        .instr          (imem_insn),
        // Outputs
        .IF_ins         (IF_ins),
        // Traces
        .TRACE_ins      (trace_instruction)
    );
    
/*----------------Instruction Decode----------------*/

    wire DCR_wr_en, DCR_mem_en, DCR_mem_wr, DCR_imm_sel;
    wire [2:0] DCR_fn_3;
    wire [4:0] DCR_rd_sel, DCR_rs1_sel, DCR_rs2_sel;
    wire [6:0] DCR_fn_7, DCR_opcode;
    wire [11:0] DCR_imm_val;

    wire [4:0] RAW_rs1_sel, RAW_rs2_sel;
    wire [31:0] RAW_rs1_val, RAW_rs2_val;

    decoder dcr(
        // Inputs
        .IF_ins         (IF_ins),
        // Outputs
        .DCR_wr_en       (DCR_wr_en),
        .DCR_mem_en      (DCR_mem_en),
        .DCR_mem_wr      (DCR_mem_wr),
        .DCR_imm_sel     (DCR_imm_sel),
        .DCR_fn_3        (DCR_fn_3),
        .DCR_rd_sel      (DCR_rd_sel),
        .DCR_rs1_sel     (DCR_rs1_sel),
        .DCR_rs2_sel     (DCR_rs2_sel),
        .DCR_fn_7        (DCR_fn_7),
        .DCR_opcode      (DCR_opcode),
        .DCR_imm_val     (DCR_imm_val)
    );

    wire [31:0] MUX_mux_val;
    
    mux_alu mux(
        // Inputs
        .DCR_imm_sel     (DCR_imm_sel),
        .DCR_imm_val     (DCR_imm_val),
        .RAW_rs2_val     (RAW_rs2_val),
        // Outputs
        .MUX_mux_val     (MUX_mux_val),
        // Traces
        .TRACE_imm_val  (trace_imm)
    );    
    
    wire ID_wr_en, ID_mem_en, ID_mem_wr;
    wire [2:0] ID_fn_3;
    wire [4:0] ID_rd_sel;
    wire [6:0] ID_opcode, ID_fn_7;
    wire [31:0] ID_rs1_val, ID_mux_val, ID_rs2_val;
    
    pipeline_reg_decoder prd(
        // Inputs
        .clk            (clk),
        .IF_wr_en       (DCR_wr_en),
        .IF_mem_en      (DCR_mem_en),
        .IF_mem_wr      (DCR_mem_wr),
        .IF_fn_3        (DCR_fn_3),
        .IF_rd_sel      (DCR_rd_sel),
        .IF_opcode      (DCR_opcode),
        .IF_fn_7        (DCR_fn_7),
        .IF_rs1_val     (RAW_rs1_val),
        .IF_mux_val     (MUX_mux_val),
        // Outputs
        .ID_wr_en       (ID_wr_en),
        .ID_mem_en      (ID_mem_en),
        .ID_mem_wr      (ID_mem_wr),
        .ID_stall       (ID_stall),
        .ID_fn_3        (ID_fn_3),
        .ID_rd_sel      (ID_rd_sel),
        .ID_opcode      (ID_opcode),
        .ID_fn_7        (ID_fn_7),
        .ID_rs1_val     (ID_rs1_val),
        .ID_mux_val     (ID_mux_val),
        .ID_rs2_val     (ID_rs2_val)
    );
    
/*----------------Execute----------------*/

    wire [31:0] ALU_alu_val;

    alu alu(
        // Inputs
        .ID_fn_3        (ID_fn_3),
        .ID_opcode      (ID_opcode),
        .ID_fn_7        (ID_fn_7),
        .ID_rs1_val     (ID_rs1_val),
        .ID_mux_val     (ID_mux_val),
        // Outputs
        .ALU_alu_val    (ALU_alu_val)
    );    
    
    wire EX_wr_en, EX_mem_en, EX_mem_wr;
    wire [4:0] EX_rd_sel, EX_raw_sel;
    wire [31:0] EX_alu_val, EX_raw_val;
    
    pipeline_reg_alu pra(
        // Inputs
        .clk            (clk),
        .ID_wr_en       (ID_wr_en),
        .ID_mem_en      (ID_mem_en),
        .ID_mem_wr      (ID_mem_wr),
        .ID_stall       (ID_stall),
        .ID_rd_sel      (ID_rd_sel),
        .ID_alu_val     (ALU_alu_val),
        .ID_rs2_val     (ID_rs2_val),
        // Outputs
        .EX_wr_en       (EX_wr_en),
        .EX_mem_en      (EX_mem_en),
        .EX_mem_wr      (EX_mem_wr),
        .EX_stall       (EX_stall),
        .EX_rd_sel      (EX_rd_sel),
        .EX_raw_sel     (EX_raw_sel),
        .EX_alu_val     (EX_alu_val),
        .EX_raw_val     (EX_raw_val)
    );
    
/*----------------Memory----------------*/

    wire MEM_wr_en;
    wire [4:0] MEM_rd_sel, MEM_raw_sel;
    wire [31:0] MEM_alu_val, MEM_raw_val;

    pipeline_reg_memory prm(
        // Inputs
        .clk            (clk),
        .EX_wr_en       (EX_wr_en),
        .EX_mem_en      (EX_mem_en),
        .EX_mem_wr      (EX_mem_wr),
        .EX_stall       (EX_stall),
        .EX_rd_sel      (EX_rd_sel),
        .EX_alu_val     (EX_alu_val),
        // Outputs
        .MEM_wr_en      (MEM_wr_en),
        .MEM_stall      (MEM_stall),
        .MEM_rd_sel     (MEM_rd_sel),
        .MEM_raw_sel    (MEM_raw_sel),
        .MEM_alu_val    (MEM_alu_val),
        .MEM_raw_val    (MEM_raw_val),
        // In-Outs
        .dram           (dmem_data)
    );
    
/*----------------Write Back----------------*/

    //wire WB_wr_en;
    //wire [4:0] WB_rd_sel, WB_raw_sel;
    //wire [31:0] WB_rd_val, WB_raw_val;
    
    /*
    pipeline_reg_writeback prw(
        // Inputs
        .clk            (),
        .MEM_wr_en      (),
        .MEM_rd_sel     (),
        .MEM_rd_val     (),
        // Outputs
        .WB_wr_en       (),
        .WB_rd_sel      (),
        .WB_raw_sel     (),
        .WB_rd_val      (),
        .WB_raw_val     ()
    );            
    */
    wire [31:0] RGF_rs1_val, RGF_rs2_val;

    register_file rgf(
        // Inputs
        .clk(clk),
        .WB_wr_en       (MEM_wr_en),
        .WB_rd_sel      (MEM_rd_sel),
        .RAW_rs1_sel    (RAW_rs1_sel),
        .RAW_rs2_sel    (RAW_rs2_sel),
        .WB_rd_val      (MEM_alu_val),
        // Outputs
        .RGF_rs1_val    (RGF_rs1_val),
        .RGF_rs2_val    (RGF_rs2_val),
        // Traces
        .TRACE_rd_sel   (trace_rd),
        .TRACE_rs1_sel  (trace_rs1),
        .TRACE_rs2_sel  (trace_rs2),
        .TRACE_wb_val   (trace_rd_value) 
    );

    raw_handler rwh(
        // Inputs
        .clk            (clk),
        .EX_stall       (EX_stall),
        .MEM_stall      (MEM_stall),
        .DCR_rs1_sel    (DCR_rs1_sel),
        .DCR_rs2_sel    (DCR_rs2_sel),
        .EX_raw_sel     (EX_raw_sel),
        .MEM_raw_sel    (MEM_raw_sel),
        //.WB_raw_sel     (WB_raw_sel),
        .RGF_rs1_val    (RGF_rs1_val),
        .RGF_rs2_val    (RGF_rs2_val),
        .EX_raw_val     (EX_raw_val),
        .MEM_raw_val    (MEM_raw_val),
        //.WB_raw_val     (WB_raw_val),
        // Outputs
        .RAW_rs1_sel    (RAW_rs1_sel),
        .RAW_rs2_sel    (RAW_rs2_sel),
        .RAW_rs1_val    (RAW_rs1_val),
        .RAW_rs2_val    (RAW_rs2_val),
        .stall          (stall)
    );    

endmodule