`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2025 09:10:49 PM
// Design Name: 
// Module Name: register_file
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


module register_file(
    input clk, write_enable,
    input [4:0] rd_sel_in, rs1_sel_in, rs2_sel_in,
    input [31:0] write_data_in,
    output reg [31:0] rs1_value_out, rs2_value_out
);

    // Register file: 32 registers, each 32 bits wide
    reg [31:0] registers [0:31];

    // Asynchronous read: Read values based on rs1 and rs2 select inputs
    always @(*) begin
        rs1_value_out = (rs1_sel_in == 5'b00000) ? 32'b0 : registers[rs1_sel_in];
        rs2_value_out = (rs2_sel_in == 5'b00000) ? 32'b0 : registers[rs2_sel_in];
    end

    // Synchronous write: Write data on clock edge if enabled
    always @(posedge clk) begin
        if (write_enable && rd_sel_in != 5'b00000)  // Prevents writing to register 0
            registers[rd_sel_in] <= write_data_in;
    end

endmodule

