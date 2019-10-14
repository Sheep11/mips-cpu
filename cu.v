module cu(
    input [5:0] op,
    input [5:0] func,
    input [4:0] sa,
    output [15:0] alu_op,
    output src1_is_sa,
    output src2_is_imm,
    output dst_is_rt,
    output reg_we,
    output dm_we,
    output reg_from_dm,
    output [1:0] npc_sel
);

parameter lui = 6'b001111;
parameter addiu = 6'b001001;
parameter add_func = 6'b100000;
parameter lw = 6'b100011;
parameter sw = 6'b101011;
parameter beq = 6'b000100;
parameter sra_func = 6'b000011;
parameter j = 6'b000010;

wire inst_lui;
wire inst_addiu;
wire inst_add;
wire inst_lw;
wire inst_sw;
wire inst_beq;
wire inst_sra;
wire inst_j;

assign inst_lui    = op == lui;
assign inst_addiu  = op == addiu;
assign inst_add   = (op == 6'b0) & (func == add_func);
assign inst_lw     = op == lw;
assign inst_sw     = op == sw;
assign inst_beq    = op == beq;
assign inst_sra    = (op == 6'b0) & (func == sra_func);
assign inst_j      = op == j;

assign alu_op[0] = inst_add | inst_addiu | inst_lw | inst_sw;
assign alu_op[1] = inst_sra;
assign alu_op[2] = inst_lui;

assign src1_is_sa   = inst_sra;
assign src2_is_imm  = inst_addiu | inst_lui | inst_lw | inst_sw;
assign dst_is_rt    = inst_addiu | inst_lui | inst_lw;
assign reg_we       = ~inst_sw & ~inst_beq  & ~inst_j;
assign dm_we        = inst_sw;
assign reg_from_dm  = inst_lw;
assign npc_sel      = inst_beq ? 2'b10:
                       inst_j   ? 2'b01:
                       2'b00;
                    
endmodule