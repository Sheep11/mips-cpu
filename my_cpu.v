module my_cpu(
    input   clk,
    input   rst
);

wire [31:0] pc;
wire [31:0] npc;
wire [ 5:0] op;
wire [ 4:0] rs;
wire [ 4:0] rt;
wire [ 4:0] rd;
wire [ 4:0] sa;
wire [ 5:0] func;
wire [15:0] imm16;
wire [25:0] imm26;
wire [1:0] npc_sel;
wire [7:0] alu_op;
wire src1_is_sa;
wire src2_is_imm;
wire dst_is_rt;
wire reg_we;
wire dm_we;
wire reg_from_dm;
wire [4:0] reg_waddr;
wire [31:0] reg_wdata;
wire [31:0] a, b;
wire a_b_equal;
wire [31:0] reala;
wire [31:0] realb;
wire [31:0] alu_result;
wire [31:0] dm_out;


pc u_pc(
    .clk(clk),
    .rst(rst),
    .npc(npc),
    .pc(pc));    //Output

assign a_b_equal = a==b;
npc_logic u_npc(
    .imm16(imm16),
    .imm26(imm26),
    .pc(pc),
    .sel(npc_sel),   
    .a_b_equal(a_b_equal),
    .npc(npc)); //Output

im u_im(
    .clk(clk),
    .pc(pc),  
    .op(op),    //Output
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .sa(sa),
    .func(func),
    .imm16(imm16),
    .imm26(imm26)
);

cu u_cu(
    .op(op),
    .func(func),
    .sa(sa),
    .alu_op(alu_op),    //Output
    .src1_is_sa(src1_is_sa),
    .src2_is_imm(src2_is_imm),
    .dst_is_rt(dst_is_rt),
    .reg_we(reg_we),
    .dm_we(dm_we),
    .reg_from_dm(reg_from_dm),
    .npc_sel(npc_sel)
);

assign reg_waddr = dst_is_rt ? rt : rd;
assign reg_wdata = reg_from_dm ? dm_out : alu_result;
regfile u_regfile(
    .clk(clk),
    .rs(rs),
    .rt(rt),
    .we(reg_we),
    .waddr(reg_waddr),
    .wdata(reg_wdata),
    .a(a),   //output
    .b(b)
);

assign reala = src1_is_sa ? {27'b0, sa[4:0]} : a;
assign realb = src2_is_imm ? {{16{imm16[15]}}, imm16[15:0]} : b;
alu u_alu(
    .alu_op(alu_op),
    .alu_src1(reala),
    .alu_src2(realb),
    .alu_result(alu_result)
);

ram dm(
    .clk(clk),
    .we(dm_we),
    .addr(alu_result[11:2]),
    .din(b),
    .dout(dm_out) //output
);

endmodule