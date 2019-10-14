module ram(
    input wire clk,
    input wire we,
    input wire [9:0] addr,
    input wire [31:0] din,
    output wire [31:0] dout);

    reg [31:0] mm[1023:0];
    assign dout=mm[addr];
    
    always@(posedge clk)
        if(we)
            begin
                mm[addr]<=din;
            end
endmodule