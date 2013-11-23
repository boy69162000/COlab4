//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
    RegWrite_o,
    ALU_op_o,
    ALUSrc_o,
    RegDst_o,
    Branch_o,
    sign_o,
    BranchType_o,
    Jump_o,
    MemRead_o,
    MemWrite_o,
    MemtoReg_o,
    );

//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output [2-1:0] RegDst_o;
output         Branch_o;
output         sign_o;
output [2-1:0] BranchType_o;
output         Jump_o;
output         MemRead_o;
output         MemWrite_o;
output [2-1:0] MemtoReg_o;

//Internal Signals
reg            ALUSrc_o;

reg [14:0]control_o;

assign { RegWrite_o, ALU_op_o, RegDst_o, Branch_o, sign_o,
         BranchType_o, Jump_o, MemRead_o, MemWrite_o, MemtoReg_o } = control_o;

//Main Function
always@(*) begin
    case(instr_op_i)
        6'b000011: control_o <= 15'b1_011_10_01_00_100_11;    // jal
        6'b100011: control_o <= 15'b1_110_00_01_00_010_01;    // lw
        6'b101011: control_o <= 15'b0_110_00_01_00_001_00;    // st
        6'b000010: control_o <= 15'b0_011_01_01_00_100_00;    // jump
        6'b000111: control_o <= 15'b0_011_01_11_01_000_00;    // bgt
        6'b000101: control_o <= 15'b0_011_01_11_11_000_00;    // bnez
        6'b000001: control_o <= 15'b0_011_01_11_10_000_00;    // bgez
        6'b000100: control_o <= 15'b0_011_01_11_00_000_00;    // beq
        6'b001000: control_o <= 15'b1_110_00_01_00_000_00;    // addi
        6'b001111: control_o <= 15'b1_110_00_00_00_000_00;    // lui
        6'b001101: control_o <= 15'b1_101_00_00_00_000_00;    // ori
        default:   control_o <= 15'b1_000_01_01_00_000_00;    // R-type
    endcase

    ALUSrc_o <= instr_op_i[3] | instr_op_i[5];

end

endmodule

