`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 02/20/2025 04:34:50 PM
// Design Name: RISC-V CPU Tracer
// Module Name: trace_logger
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: NA
// Tool Versions: NA
// Description: Tracks CPU values during the pipeline stages and prints to console.
// 
// Dependencies: NA
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module trace_logger(
    input clk,
    input rst_n,
    input [31:0] trace_instruction,
    input signed [31:0] trace_rd_value, imm,
    input [4:0] trace_rd, trace_rs1, trace_rs2
);

    // Array to hold the immediate value for 1 cycle
    reg signed [31:0] imm_reg;    

    // Array to hold the rs1 for 2 cycles
    reg [4:0] rs1_reg[1:0];        

    // Array to hold the instruction for 3 cycles
    reg [31:0] instr_reg [2:0];
    integer i;
    
    // Shift the instruction through the register array on each clock cycle
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            // Reset the instruction register array
            for (i = 0; i < 3; i = i + 1) begin
                instr_reg[i] <= 32'b0;
            end
        end
        else begin
            // Shift the instruction through the register array
            instr_reg[0] <= trace_instruction;  // Current instruction
            instr_reg[1] <= instr_reg[0];       // Delay by 1 cycle
            instr_reg[2] <= instr_reg[1];       // Delay by 2 cycles
            // Pass new imm value
            imm_reg <= imm;
            rs1_reg[0] <= trace_rs1;
            rs1_reg[1] <= rs1_reg[0];
        end
    end
  
    initial begin
        $display("Instr \t\t | \t rd \t | \t rs1 \t | \t\t imm \t | \t\t [rd]");
    end
    
    always @(posedge clk) begin
        if (rst_n && instr_reg[2] != 0) begin
            // Display instruction
            $display("%h \t | \t x%d \t | \t x%d \t | %d \t | \t %d", instr_reg[2], trace_rd, rs1_reg[1], imm_reg, trace_rd_value);
        end
    end
    
endmodule
