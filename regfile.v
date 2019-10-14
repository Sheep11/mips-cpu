module regfile(
    input         clk,
    input  [ 4:0] rs,
    input  [ 4:0] rt,
    // WRITE PORT
    input         we,       //write enable, HIGH valid
    input  [ 4:0] waddr,
    input  [31:0] wdata,
    output [31:0] a,
    output [31:0] b
);
reg [31:0] rf[31:0];

assign a = rf[rs];
assign b = rf[rt];

always@(posedge clk)
    if(we)
        rf[waddr] = wdata;

endmodule