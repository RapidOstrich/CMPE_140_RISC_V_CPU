`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJSU
// Engineer: Spenser The
// 
// Create Date: 02/20/2025 04:34:50 PM
// Design Name: Clock Cycle Counter
// Module Name: cc_counter
// Project Name: CMPE 140 RISC-V Processor
// Target Devices: NA
// Tool Versions: NA
// Description: Increments counter every clock cycle.
// 
// Dependencies: NA
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cc_counter(
    input rst_n, clk,
    output reg [15:0] cc_count
);

    /*----Program Start Flag----*/
    reg prog_start;
    
    /*----Init Counter & Flag----*/
    initial begin
        cc_count <= 0;
        prog_start <= 0;
    end
    
    always @(posedge clk) begin
        if (rst_n) begin
            prog_start <= 1;
        end
        // ELSE block?

        if (prog_start) begin
            cc_count <= cc_count + 1; 
        end
    end
    
endmodule
