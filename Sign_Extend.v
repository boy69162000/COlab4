//Subject:     CO project 2 - Sign extend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module Sign_Extend(
    data_i,
    sign_i,
    data_o
    );

//I/O ports
input   [16-1:0] data_i;
input            sign_i;
output  [32-1:0] data_o;

//Internal Signals
reg     [32-1:0] data_o;

//Sign extended
always@(*) begin
    // in ori, the immediate part needs zero extension
    data_o <= sign_i ? {{16{data_i[15]}}, data_i} :
                       {{16{1'b0}},       data_i};
end

endmodule

