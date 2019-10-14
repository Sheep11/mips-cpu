module pc(
    input   clk,
    input   rst,
    input   [31:0]  npc,
    output  reg [31:0]  pc
);

reg period;

always@(posedge clk) begin
    period<=~period;
    if(rst) 
        pc<=32'b0;
    else    
        pc<=npc;
end

endmodule