`default_nettype none
`timescale 1ns/1ns
module debounce #(
    parameter HIST_LEN = 8
)(
    input wire clk,
    input wire reset,
    input wire button,
    input wire strobe,
    output reg debounced
);
    localparam on_value = 2 ** HIST_LEN - 1;
    reg [HIST_LEN-1:0] button_hist;

    always @(posedge clk) begin
        if(reset) begin

            button_hist <= 0;
            debounced <= 1'b0;

        end else if (strobe == 1'b1) begin

            button_hist <= {button_hist[HIST_LEN-2:0], button};

            if(button_hist == on_value)
                debounced <= 1'b1;

            else if(button_hist == {HIST_LEN{1'b0}})
                debounced <= 1'b0;
       end
    end

endmodule
