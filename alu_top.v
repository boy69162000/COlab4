`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Student: ???
// ID: 0016014
//
// Create Date:    10:58:01 10/10/2011
// Design Name:
// Module Name:    alu_top
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               //bonus,      //bonus          (input)
               result,     //1 bit result   (output)
               cout        //1 bit carry out(output)
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;
//input [3-1:0] bonus;

output        result;
output        cout;

reg           result;
reg           cout;

always@(*) begin
    cout <= ((src1^A_invert) & (src2^B_invert)) | ((src1^A_invert)&cin) | ((src2^B_invert)&cin);
    case(operation[1:0])
        2'b00: result <= (src1^A_invert) & (src2^B_invert);
        2'b01: result <= (src1^A_invert) | (src2^B_invert);
        2'b10: result <= (src1^A_invert) ^ (src2^B_invert) ^ cin;
        2'b11: result <= less;
    endcase
end

endmodule
