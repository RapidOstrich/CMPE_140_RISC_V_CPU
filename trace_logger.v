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
    
    integer fd_1, fd_2, count;
    
    initial begin
        count = 0;
        fd_1 = $fopen("C:\\Users\\spens\\Desktop\\program_count.txt", "w");
        fd_2 = $fopen("C:\\Users\\spens\\Desktop\\write_back.txt", "w");
        
        if (fd_1 == 0) begin
            $display("Error opening program_count.txt");
        end
        
        if (fd_2 == 0) begin
            $display("Error opening write_back.txt");            
        end
    
        $display("Instr \t\t | \t rd \t | \t rs1 \t | \t rs2 \t | \t imm \t | \t [rd]");
        
        #435;
        $fclose(fd_1);
        $fclose(fd_2);           
    end
    
    always @(posedge clk) begin
        if (rst_n) begin                   
            $display("%h \t | \t x%d \t | \t x%d \t | \t x%d \t | %d \t |  %d", trace_instruction, trace_rd, trace_rs1, trace_rs2, trace_imm, trace_rd_value);
        end
    end
    
    always @(posedge clk) begin    
        if (fd_1 != 0 && fd_2 != 0) begin              
           $fwrite(fd_1, "Instruction: %h\n", trace_instruction);
           $fwrite(fd_2, "Register: %b, Write-in value: %d\n", trace_rd, trace_rd_value);            
        end 
    end
    
endmodule
