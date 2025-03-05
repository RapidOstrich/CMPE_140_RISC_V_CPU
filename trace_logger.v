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
    input signed [31:0] trace_rd_value,
    input signed [11:0] trace_imm,
    input [4:0] trace_rd, trace_rs1, trace_rs2
);
    
    initial begin
        $display("Instr \t\t | \t rd \t | \t rs1 \t | \t imm \t | \t [rd]");
    end
    
    always @(posedge clk) begin
        if (rst_n) begin                   
            $display("%h \t | \t x%d \t | \t x%d \t | %d \t |  %d", trace_instruction, trace_rd, trace_rs1, trace_imm, trace_rd_value);
        end
    end
    
endmodule
