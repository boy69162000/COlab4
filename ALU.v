//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module alu(
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
           bonus_control, // 3 bits bonus control input(input 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );

input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
input   [3-1:0] bonus_control;

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

reg    [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;

wire   [32-1:0] R, shiftR;
wire   [64-1:0] mulR;
wire            c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15;
wire            c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31;
wire            set;
reg   [32-1:0] s1, s2, s3, s4, s5;

alu_top alu0(src1[0], src2[0], set, ALU_control[3], ALU_control[2], ALU_control[3]^ALU_control[2], ALU_control[1:0],/* bonus_control[2:0],*/ R[0], c0);
alu_top alu1(src1[1], src2[1], 1'b0, ALU_control[3], ALU_control[2], c0, ALU_control[1:0], R[1], c1);
alu_top alu2(src1[2], src2[2], 1'b0, ALU_control[3], ALU_control[2], c1, ALU_control[1:0], R[2], c2);
alu_top alu3(src1[3], src2[3], 1'b0, ALU_control[3], ALU_control[2], c2, ALU_control[1:0], R[3], c3);
alu_top alu4(src1[4], src2[4], 1'b0, ALU_control[3], ALU_control[2], c3, ALU_control[1:0], R[4], c4);
alu_top alu5(src1[5], src2[5], 1'b0, ALU_control[3], ALU_control[2], c4, ALU_control[1:0], R[5], c5);
alu_top alu6(src1[6], src2[6], 1'b0, ALU_control[3], ALU_control[2], c5, ALU_control[1:0], R[6], c6);
alu_top alu7(src1[7], src2[7], 1'b0, ALU_control[3], ALU_control[2], c6, ALU_control[1:0], R[7], c7);
alu_top alu8(src1[8], src2[8], 1'b0, ALU_control[3], ALU_control[2], c7, ALU_control[1:0], R[8], c8);
alu_top alu9(src1[9], src2[9], 1'b0, ALU_control[3], ALU_control[2], c8, ALU_control[1:0], R[9], c9);
alu_top alu10(src1[10], src2[10], 1'b0, ALU_control[3], ALU_control[2], c9, ALU_control[1:0], R[10], c10);
alu_top alu11(src1[11], src2[11], 1'b0, ALU_control[3], ALU_control[2], c10, ALU_control[1:0], R[11], c11);
alu_top alu12(src1[12], src2[12], 1'b0, ALU_control[3], ALU_control[2], c11, ALU_control[1:0], R[12], c12);
alu_top alu13(src1[13], src2[13], 1'b0, ALU_control[3], ALU_control[2], c12, ALU_control[1:0], R[13], c13);
alu_top alu14(src1[14], src2[14], 1'b0, ALU_control[3], ALU_control[2], c13, ALU_control[1:0], R[14], c14);
alu_top alu15(src1[15], src2[15], 1'b0, ALU_control[3], ALU_control[2], c14, ALU_control[1:0], R[15], c15);
alu_top alu16(src1[16], src2[16], 1'b0, ALU_control[3], ALU_control[2], c15, ALU_control[1:0], R[16], c16);
alu_top alu17(src1[17], src2[17], 1'b0, ALU_control[3], ALU_control[2], c16, ALU_control[1:0], R[17], c17);
alu_top alu18(src1[18], src2[18], 1'b0, ALU_control[3], ALU_control[2], c17, ALU_control[1:0], R[18], c18);
alu_top alu19(src1[19], src2[19], 1'b0, ALU_control[3], ALU_control[2], c18, ALU_control[1:0], R[19], c19);
alu_top alu20(src1[20], src2[20], 1'b0, ALU_control[3], ALU_control[2], c19, ALU_control[1:0], R[20], c20);
alu_top alu21(src1[21], src2[21], 1'b0, ALU_control[3], ALU_control[2], c20, ALU_control[1:0], R[21], c21);
alu_top alu22(src1[22], src2[22], 1'b0, ALU_control[3], ALU_control[2], c21, ALU_control[1:0], R[22], c22);
alu_top alu23(src1[23], src2[23], 1'b0, ALU_control[3], ALU_control[2], c22, ALU_control[1:0], R[23], c23);
alu_top alu24(src1[24], src2[24], 1'b0, ALU_control[3], ALU_control[2], c23, ALU_control[1:0], R[24], c24);
alu_top alu25(src1[25], src2[25], 1'b0, ALU_control[3], ALU_control[2], c24, ALU_control[1:0], R[25], c25);
alu_top alu26(src1[26], src2[26], 1'b0, ALU_control[3], ALU_control[2], c25, ALU_control[1:0], R[26], c26);
alu_top alu27(src1[27], src2[27], 1'b0, ALU_control[3], ALU_control[2], c26, ALU_control[1:0], R[27], c27);
alu_top alu28(src1[28], src2[28], 1'b0, ALU_control[3], ALU_control[2], c27, ALU_control[1:0], R[28], c28);
alu_top alu29(src1[29], src2[29], 1'b0, ALU_control[3], ALU_control[2], c28, ALU_control[1:0], R[29], c29);
alu_top alu30(src1[30], src2[30], 1'b0, ALU_control[3], ALU_control[2], c29, ALU_control[1:0], R[30], c30);
alu_top alu31(src1[31], src2[31], 1'b0, ALU_control[3], ALU_control[2], c30, ALU_control[1:0], R[31], c31);
assign set = (src1[31]^ALU_control[3])^(src2[31]^ALU_control[2])^c30;

//shift
always@(*) begin
    case(ALU_control)
        4'b1111: begin
            case(bonus_control)
                3'b101: s1 <= (src1[0]==1'b1 ? {1'd0, src2[31:1]} : src2); 
                default: s1 <= (src1[0]==1'b1 ? {src2[30:0], 1'd0} : src2); 
            endcase
        end
        default: s1 <= 32'd0;
    endcase
end

always@(*) begin
    case(ALU_control)
        4'b1111: begin
            case(bonus_control)
                3'b101: s2 <= (src1[1]==1'b1 ? {2'd0, s1[31:2]} : s1); 
                default: s2 <= (src1[1]==1'b1 ? {s1[29:0], 2'd0} : s1); 
            endcase
        end
        default: s2 <= 32'd0;
    endcase
end

always@(*) begin
    case(ALU_control)
        4'b1111: begin
            case(bonus_control)
                3'b101: s3 <= (src1[2]==1'b1 ? {4'd0, s2[31:4]} : s2);
                default: s3 <= (src1[2]==1'b1 ? {s2[27:0], 4'd0} : s2);
            endcase
        end
        default: s3 <= 32'd0;
    endcase
end

always@(*) begin
    case(ALU_control)
        4'b1111: begin
            case(bonus_control)
                3'b101: s4 <= (src1[3]==1'b1 ? {8'd0, s3[31:8]} : s3);
                default: s4 <= (src1[3]==1'b1 ? {s3[23:0], 8'd0} : s3);
            endcase
        end
        default: s4 <= 32'd0;
    endcase
end

always@(*) begin
    case(ALU_control)
        4'b1111: begin
            case(bonus_control)
                3'b101: s5 <= (src1[4]==1'b1 ? {16'd0, s3[31:16]} : s4);
                default: s5 <= (src1[4]==1'b1 ? {s3[15:0], 16'd0} : s4);
            endcase
        end
        default: s5 <= 32'd0;
    endcase
end

assign shiftR = s5;
assign mulR = src1 * src2;

///
always@(*) begin
    case(rst_n)
        1'b0: begin 
            result = 32'd0;
            zero = 1'b0;
            cout = c31;
            overflow = 1'b0;
        end
        1'b1: begin
            case(ALU_control[3:0])
                4'b1111: result[31:0] <= shiftR[31:0];
                4'b1011: result[31:0] <= mulR[31:0];
                default: result[31:0] <= R[31:0];
            endcase
            
            case(result[31:0])
                32'd0: zero <= 1'b1;
                default: zero <= 1'b0;
            endcase
            cout <= c31&ALU_control[1]&~ALU_control[0];
            overflow <= (((src1[31]^ALU_control[3])&(src2[31]^ALU_control[2]))^result[31])&(ALU_control[1]&~ALU_control[0])&~((src1[31]^ALU_control[3])^(src2[31]^ALU_control[2]));
        end
    endcase
end

endmodule
