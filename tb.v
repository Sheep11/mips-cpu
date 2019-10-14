`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/27 14:01:24
// Design Name: 
// Module Name: tb
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


module tb(
    );
    reg clk;
    reg rst;
    
    initial begin
        clk = 1;
        rst = 0;
        #8 rst = 1;
        #5 rst = 0;
    end
    
    initial begin    
        cpu.u_regfile.rf[0] = 32'b0;
        cpu.u_regfile.rf[1] = 32'b0;
        cpu.u_regfile.rf[2] = 32'b0;
        cpu.u_regfile.rf[3] = 32'b0;
        cpu.u_regfile.rf[4] = 32'b0;
        cpu.u_regfile.rf[5] = 32'b0;
        cpu.u_regfile.rf[6] = 32'b0;
        cpu.u_regfile.rf[7] = 32'b0;
        cpu.u_regfile.rf[8] = 32'b0;
        cpu.u_regfile.rf[9] = 32'b0;
        cpu.u_regfile.rf[10] = 32'b0;
        cpu.u_regfile.rf[11] = 32'b0;
        cpu.u_regfile.rf[12] = 32'b0;
        cpu.u_regfile.rf[13] = 32'b0;
        cpu.u_regfile.rf[14] = 32'b0;
        cpu.u_regfile.rf[15] = 32'b0;
        cpu.u_regfile.rf[16] = 32'b0;
        cpu.u_regfile.rf[17] = 32'b0;
        cpu.u_regfile.rf[18] = 32'b0;
        cpu.u_regfile.rf[19] = 32'b0;
        cpu.u_regfile.rf[20] = 32'b0;
        cpu.u_regfile.rf[21] = 32'b0;
        cpu.u_regfile.rf[22] = 32'b0;
        cpu.u_regfile.rf[23] = 32'b0;
        cpu.u_regfile.rf[24] = 32'b0;
        cpu.u_regfile.rf[25] = 32'b0;
        cpu.u_regfile.rf[26] = 32'b0;
        cpu.u_regfile.rf[27] = 32'b0;
        cpu.u_regfile.rf[28] = 32'b0;
        cpu.u_regfile.rf[29] = 32'b0;
        cpu.u_regfile.rf[30] = 32'b0;
        cpu.u_regfile.rf[31] = 32'b0;

        cpu.u_im.mem.mm[0] = {6'b001001, 5'b0, 5'd1, 16'd2};    //addiu     reg[1]=0+2
        cpu.u_im.mem.mm[1] = {6'b001111, 5'b0, 5'd0, 16'd3};    //lui       reg[0]={16'd3, 16'd0}
        cpu.u_im.mem.mm[2] = {6'b000000, 5'd0, 5'd1, 5'd2, 5'b0, 6'b100000};    //add   reg[2]=reg[0]+reg[1]
        cpu.u_im.mem.mm[3] = {6'b101011, 5'd1, 5'd2, 16'd6};    //sw        dm[reg[0]+6] = reg[2] -> dm[2] = 00030002
        cpu.u_im.mem.mm[4] = {6'b100011, 5'd1, 5'd3, 16'd2};    //lw        reg[3] = dm[reg[1]+2] -> reg[3] = dm[1]
        cpu.u_im.mem.mm[5] = {6'b000000, 5'b0, 5'd0, 5'd4, 5'd2, 6'b000011};    //sra  reg[4] = reg[0] >> 2
        
        cpu.u_im.mem.mm[6] = {6'b000100, 5'd0, 5'd1, 16'd20};
        cpu.u_im.mem.mm[7] = {6'b000100, 5'd10, 5'd11, 16'd16};
        cpu.u_im.mem.mm[11] = {6'b000010, 26'b0};          

                
        cpu.dm.mm[0] = 32'd0;
        cpu.dm.mm[1] = 32'd1;
        cpu.dm.mm[2] = 32'd2;
        cpu.dm.mm[3] = 32'd3;
        cpu.dm.mm[4] = 32'd4;
        cpu.dm.mm[5] = 32'd5;
        cpu.dm.mm[6] = 32'd6;
        cpu.dm.mm[7] = 32'd7;

    end
    
    always #5 clk = ~clk;
    
    my_cpu cpu(
        .clk(clk),
        .rst(rst)
    );
    
endmodule
