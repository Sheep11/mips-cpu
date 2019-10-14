module mux(
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire mux_sel,
    output wire [31:0]out );

assign out=(mux_sel=='b1)?in2:in1;

endmodule