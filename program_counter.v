`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 02/20/2025 04:34:50 PM
// Design Name: RISC-V Program Counter
// Module Name: program_counter
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: NA
// Tool Versions: NA
// Description: Program counter for RISC-V processor
// 
// Dependencies: NA
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module program_counter(
    input clk, rst_n,
    output reg [31:0] program_count
);

    always @(posedge clk) begin
        if (!rst_n) begin
            program_count <= 0;
        end
        else begin
            program_count <= program_count + 4;
        end
    end

endmodule
