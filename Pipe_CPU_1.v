//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
        clk_i,
        rst_n
        );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles

wire [31:0] pc, pci, pcx, pco;
wire [31:0] SAex;
wire [31:0] sl2data;

wire [3:0]  aluctrl;
wire [2:0]  bonusctrl;
wire [31:0] src1, src2, wdata;
wire        cout, overflow, rzmux;

//Pipe Reg
//IF/ID
wire [31:0] pcn_i_ifid, instr_i_ifid;

wire [31:0] pcn_o_ifid, instr_o_ifid;
//ID/EX
wire [31:0] rdata1_i_idex, rdata2_i_idex, SAex_i_idex;
wire [2:0]  aluop_i_idex;
wire [1:0]  regd_i_idex, btype_i_idex, mtor_i_idex;
wire        regw_i_idex, alusrc_i_idex, branch_i_idex, sign_i_idex, j_i_idex, memr_i_idex, memw_i_idex;

wire [31:0] rdata1_o_idex, rdata2_o_idex, SAex_o_idex, pcn_o_idex;
wire [25:0] instr_o_idex;
wire [2:0]  aluop_o_idex;
wire [1:0]  regd_o_idex, btype_o_idex, mtor_o_idex;
wire        regw_o_idex, alusrc_o_idex, branch_o_idex, sign_o_idex, j_o_idex, memr_o_idex, memw_o_idex;
//EX/MEM
wire [31:0] aluresult_i_exmem, pcb_i_exmem, signex_i_exmem;
wire [4:0]  regtow_i_exmem;
wire        zero_i_exmem;

wire [31:0] aluresult_o_exmem, pcb_o_exmem, pcn_o_exmem, jaddr_o_exmem, rdata1_o_exmem, rdata2_o_exmem, signex_o_exmem;
wire [4:0]  regtow_o_exmem;
wire [1:0]  btype_o_exmem, mtor_o_exmem;
wire        zero_o_exmem, regw_o_exmem, branch_o_exmem, j_o_exmem, memr_o_exmem, memw_o_exmem, bonus_o_exmem;
//MEM/WB
wire [31:0] mdata_i_memwb;

wire [31:0] mdata_o_memwb, aluresult_o_memwb, pcn_o_memwb, signex_o_memwb;
wire [4:0]  regtow_o_memwb;
wire [1:0]  mtor_o_memwb;
wire        regw_o_memwb;
//Greate componentes
//IF
MUX_2to1 #(.size(32)) Mux_Return(
        .data0_i(pcn_i_ifid),
        .data1_i(pcb_o_exmem),
        .select_i(branch_o_exmem & zero_o_exmem),
        .data_o(pc)
        );

ProgramCounter PC(
        .clk_i(clk_i),
        .rst_n(rst_n),
        .pc_in_i(pc),
        .pc_out_o(pco)
        );

Adder Adder1(
        .src1_i(32'd4),
        .src2_i(pco),
        .sum_o(pcn_i_ifid)
        );

Instr_Memory IM(
        .pc_addr_i(pco),
        .instr_o(instr_i_ifid)
        );

Pipe_Reg #(.size(64)) IF_ID(       
            .clk_i(clk_i),
            .rst_n(rst_n),
            .stall(branch_o_exmem & zero_o_exmem),
            .data_i({pcn_i_ifid, instr_i_ifid}),
            .data_o({pcn_o_ifid, instr_o_ifid})
        );
//ID
Reg_File RF(
        .clk_i(clk_i),
        .rst_n(rst_n),
        .RSaddr_i(instr_o_ifid[25:21]),
        .RTaddr_i(instr_o_ifid[20:16]),
        .RDaddr_i(regtow_o_memwb),
        .RDdata_i(wdata),
        .RegWrite_i(regw_o_memwb),
        .RSdata_o(rdata1_i_idex),
        .RTdata_o(rdata2_i_idex)
        );

Decoder Decoder(
        .instr_op_i(instr_o_ifid[31:26]),
        .RegWrite_o(regw_i_idex),
        .ALU_op_o(aluop_i_idex),
        .ALUSrc_o(alusrc_i_idex),
        .RegDst_o(regd_i_idex),
        .Branch_o(branch_i_idex),
        .sign_o(sign_i_idex),
        .BranchType_o(btype_i_idex),
        .Jump_o(j_i_idex),
        .MemRead_o(memr_i_idex),
        .MemWrite_o(memw_i_idex),
        .MemtoReg_o(mtor_i_idex)
        );

ShiftAmount_Extend SA(
        .data_i(instr_o_ifid[10:6]),
        .data_o(SAex_i_idex)
        );

Pipe_Reg #(.size(170)) ID_EX(       
            .clk_i(clk_i),
            .rst_n(rst_n),
            .stall(branch_o_exmem & zero_o_exmem),
            .data_i({rdata1_i_idex, rdata2_i_idex, instr_o_ifid[25:0], pcn_o_ifid, 
                     SAex_i_idex, aluop_i_idex, regd_i_idex,
                     btype_i_idex, mtor_i_idex, regw_i_idex,
                     alusrc_i_idex, branch_i_idex, sign_i_idex,
                     j_i_idex, memr_i_idex, memw_i_idex}),
            .data_o({rdata1_o_idex, rdata2_o_idex, instr_o_idex, pcn_o_idex,
                     SAex_o_idex, aluop_o_idex, regd_o_idex,
                     btype_o_idex, mtor_o_idex, regw_o_idex,
                     alusrc_o_idex, branch_o_idex, sign_o_idex,
                     j_o_idex, memr_o_idex, memw_o_idex})
        );
//EX
ALU_Ctrl AC(
        .funct_i(instr_o_idex[5:0]),
        .ALUOp_i(aluop_o_idex),
        .ALUCtrl_o(aluctrl),
        .BonusCtrl_o(bonusctrl),
        .ALUShift_o(alush)
        );

MUX_2to1 #(.size(32)) Mux_Src1(
        .data0_i(rdata1_o_idex),
        .data1_i(SAex_o_idex),
        .select_i(alush),
        .data_o(src1)
        );

Sign_Extend SE(
        .data_i(instr_o_idex[15:0]),
        .sign_i(sign_o_idex),
        .data_o(signex_i_exmem)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(rdata2_o_idex),
        .data1_i(signex_i_exmem),
        .select_i(alusrc_o_idex),
        .data_o(src2)
        );

alu ALU(
        .rst_n(rst_n),
        .src1(src1),
        .src2(src2),
        .ALU_control(aluctrl),
        .bonus_control(bonusctrl),
        .result(aluresult_i_exmem),
        .zero(zero_i_exmem),
        .cout(cout),
        .overflow(overflow)
        );
        
MUX_4to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr_o_idex[20:16]),
        .data1_i(instr_o_idex[15:11]),
        .data2_i(5'd31),
        .data3_i(5'd31),
        .select_i(regd_o_idex),
        .data_o(regtow_i_exmem)
        );
        
Shift_Left_Two_32 Shifter(
        .data_i(signex_i_exmem),
        .data_o(sl2data)
        );
        
Adder Adder2(
        .src1_i(pcn_o_idex),
        .src2_i(sl2data),
        .sum_o(pcb_i_exmem)
        );

Pipe_Reg #(.size(240)) EX_MEM(       
            .clk_i(clk_i),
            .rst_n(rst_n),
            .stall(branch_o_exmem & zero_o_exmem),
            .data_i({aluresult_i_exmem, pcb_i_exmem,
                     pcn_o_idex, {pcn_o_idex[31:28], instr_o_idex[25:0], 2'b00},
                     rdata1_o_idex, rdata2_o_idex, signex_i_exmem,
                     btype_o_idex, mtor_o_idex,
                     regtow_i_exmem, zero_i_exmem,
                     regw_o_idex, branch_o_idex, 
                     j_o_idex, memr_o_idex,
                     bonusctrl[1], memw_o_idex}),
            .data_o({aluresult_o_exmem, pcb_o_exmem,
                     pcn_o_exmem, jaddr_o_exmem,
                     rdata1_o_exmem, rdata2_o_exmem, signex_o_exmem,
                     btype_o_exmem, mtor_o_exmem,
                     regtow_o_exmem, zero_o_exmem,
                     regw_o_exmem, branch_o_exmem, 
                     j_o_exmem, memr_o_exmem,
                     bonus_o_exmem, memw_o_exmem})
        );

//MEM
Data_Memory DM(
    .clk_i(clk_i),
    .addr_i(aluresult_o_exmem),
    .data_i(rdata2_o_exmem),
    .MemRead_i(memr_o_exmem),
    .MemWrite_i(memw_o_exmem),
    .data_o(mdata_i_memwb)
    );

MUX_4to1 #(.size(1)) Result_Zero_Mux(
        .data0_i(zero_o_exmem),
        .data1_i(~(zero_o_exmem | aluresult_o_exmem[31])),
        .data2_i(~aluresult_o_exmem[31]),
        .data3_i(~zero_o_exmem),
        .select_i(btype_o_exmem),
        .data_o(rzmux)
        );
        
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(pcn_o_exmem),
        .data1_i(pcb_o_exmem),
        .select_i((branch_o_exmem & rzmux)),
        .data_o(pcx)
        );

MUX_2to1 #(.size(32)) Mux_Jump(
        .data0_i(pcx),
        .data1_i(jaddr_o_exmem),
        .select_i(j_o_exmem),
        .data_o(pci)
        );
        
Pipe_Reg #(.size(136)) MEM_WB(       
            .clk_i(clk_i),
            .rst_n(rst_n),
            .stall(1'b0),
            .data_i({mdata_i_memwb, aluresult_o_exmem,
                     pcn_o_exmem, signex_o_exmem,
                     mtor_o_exmem, regtow_o_exmem,
                     regw_o_exmem}),
            .data_o({mdata_o_memwb, aluresult_o_memwb,
                     pcn_o_memwb, signex_o_memwb,
                     mtor_o_memwb, regtow_o_memwb,
                     regw_o_memwb})
        );
//WB
MUX_4to1 #(.size(32)) Mux_WReg_Src(
        .data0_i(aluresult_o_memwb),
        .data1_i(mdata_o_memwb),
        .data2_i(signex_o_memwb),
        .data3_i(pcn_o_memwb),
        .select_i(mtor_o_memwb),
        .data_o(wdata)
        );

endmodule


