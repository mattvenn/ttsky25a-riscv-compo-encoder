/*
 * Copyright (c) 2025 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Change the name of this module to something that reflects its functionality and includes your name for uniqueness
// For example tqvp_yourname_spi for an SPI peripheral.
// Then edit tt_wrapper.v line 38 and change tqvp_example to your chosen module name.
module tqvp_matt_encoder(
    input         clk,          // Clock - the TinyQV project clock is normally set to 64MHz.
    input         rst_n,        // Reset_n - low to reset.

    input  [7:0]  ui_in,        // The input PMOD, always available.  Note that ui_in[7] is normally used for UART RX.
                                // The inputs are synchronized to the clock, note this will introduce 2 cycles of delay on the inputs.

    output [7:0]  uo_out,       // The output PMOD.  Each wire is only connected if this peripheral is selected.
                                // Note that uo_out[0] is normally used for UART TX.

    input [3:0]   address,      // Address within this peripheral's address space

    input         data_write,   // Data write request from the TinyQV core.
    input [7:0]   data_in,      // Data in to the peripheral, valid when data_write is high.
    
    output [7:0]  data_out      // Data out from the peripheral, set this in accordance with the supplied address
);

    // assign the pins
    wire enc0_a = ui_in[0];
    wire enc0_b = ui_in[1];
    wire reset = ! rst_n;
    wire [7:0] enc0;

    // Example: Implement an 8-bit read/write register at address 0
    /*
    reg [7:0] example_data;
    always @(posedge clk) begin
        if (!rst_n) begin
            example_data <= 0;
        end else begin
            if (address == 4'h0) begin
                if (data_write) example_data <= data_in;
            end
        end
    end
    */

    // All output pins must be assigned. If not used, assign to 0.
    assign uo_out  = 0;

    // Address 0 reads encoder 0
    // All other addresses read 0.
    assign data_out = (address == 4'h0) ? enc0 :
                      8'h0;  
	
    wire enc0_a_db, enc0_b_db;
    wire deb_strobe;
    // TODO make the strobe frequency adjustable from the RISC-V CPU
    strobe_gen #(.WIDTH(14))  deb_strobe_gen(.clk(clk), .out(deb_strobe));
    debounce #(.HIST_LEN(8)) debounce0_a(.clk(clk), .strobe(deb_strobe), .reset(reset), .button(enc0_a), .debounced(enc0_a_db));
    debounce #(.HIST_LEN(8)) debounce0_b(.clk(clk), .strobe(deb_strobe), .reset(reset), .button(enc0_b), .debounced(enc0_b_db));
    encoder #(.WIDTH(8)) encoder0(.clk(clk), .reset(reset), .a(enc0_a_db), .b(enc0_b_db), .value(enc0));
endmodule

