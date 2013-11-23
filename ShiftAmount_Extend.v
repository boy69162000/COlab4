//Subject:     CO project 2 - Shift Amount extend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module ShiftAmount_Extend(
    data_i,
    data_o
    );

//I/O ports
input   [5-1:0]  data_i;
output  [32-1:0] data_o;

//Internal Signals
reg     [32-1:0] data_o;

//Sign extended (actually, fill zero)
always@(*) begin
    data_o <= {27'd0, data_i};
end

endmodule

