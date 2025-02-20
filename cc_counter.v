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


module cc_counter(
    // Active low reset, Clock, and program start flag
    input rst_n, clk,

    // Start status
    output reg prog_start,

    // Program count
    output reg [15:0] pc
    );
    
    // Start program counter & start flag at 0
    initial begin
        pc <= 0;
        prog_start = 0;
    end
    
    always @(posedge clk) begin
        if (rst_n) begin
            prog_start <= 1;
        end
    
        // ELSE block?
    
        // Increment program counter
        if (prog_start) begin
            pc <= pc + 1; 
        end
    end
    
endmodule
