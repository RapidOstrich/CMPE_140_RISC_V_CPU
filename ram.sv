`timescale 1ns/1ps

module ram #(addr_width = 4, data_width = 4, string init_file = "dummy.dat" )(
    input rst_n,
    input clk,
    input wen,
    input [addr_width-1:0]addr,
    //input [data_width-1:0] data_in,
    inout [data_width-1:0]data
);

    /*----Array of 16x4 bit RAM----*/
    reg [data_width-1:0] mem [(1 << addr_width) - 1:0];
    
    initial begin
        $readmemb(init_file, mem);
    end
        
    assign data = (rst_n) ? ( (wen) ? 'z : mem[addr]) : 'z;
    
    always_ff @ (posedge clk) begin
            if (rst_n) begin
                if (wen) begin
                    mem[addr] <= #0.1 data;
                end
            end
    end
    
endmodule
