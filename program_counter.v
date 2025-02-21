`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2025 10:34:40 AM
// Design Name: 
// Module Name: program_counter
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
