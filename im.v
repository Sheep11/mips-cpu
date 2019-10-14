module im(
    input clk,
    input [31:0] pc,
    output [5:0] op,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] sa,
    output [5:0] func,
    output [15:0] imm16,
    output [25:0] imm26
);

wire write_enable;
wire [31:0] din, inst;

assign write_enable=0;
ram mem(
    .clk(clk),
    .we(write_enable),
    .addr(pc[11:2]),
    .din(din),
    .dout(inst)
);

assign op    = inst[31:26];
assign rs    = inst[25:21];
assign rt    = inst[20:16];
assign rd    = inst[15:11];
assign sa    = inst[10: 6];
assign func  = inst[ 5: 0];
assign imm16 = inst[15: 0];
assign imm26 = inst[25: 0];

endmodule