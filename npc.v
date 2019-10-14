module npc_logic(
    input [31:0] pc,
    input [15:0] imm16,
    input [25:0] imm26,
    input [1:0] sel,
    input a_b_equal,
    output [31:0] npc
);

wire op_beq;
wire op_jmp;
wire op_seq;
wire [31:0] jmp_target;
wire [31:0] beq_target;
wire [31:0] seq_pc;

//seq=00, jmp=01, beq=10
assign op_seq = (sel == 2'b00);
assign op_jmp = (sel == 2'b01);
assign op_beq = (sel == 2'b10);

assign seq_pc = pc + 3'b100;
assign beq_target = pc + 3'b100 + {{14{imm16[15]}}, imm16, 2'b00};
assign jmp_target = {{pc[31:28]}, imm26, 2'b00};


assign npc = op_jmp             ? jmp_target :
             op_beq & a_b_equal ? beq_target : 
             seq_pc;

endmodule