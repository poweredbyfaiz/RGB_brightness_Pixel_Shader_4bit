// tb_pixel_shader_4bit.v
// Simple testbench to demonstrate functionality

`timescale 1ns / 1ps
module tb_pixel_shader_4bit;

    reg  [3:0] red_in, green_in, blue_in, bright;
    wire [3:0] red_out, green_out, blue_out;

    pixel_shader_4bit uut (
        .red_in(red_in),
        .green_in(green_in),
        .blue_in(blue_in),
        .bright(bright),
        .red_out(red_out),
        .green_out(green_out),
        .blue_out(blue_out)
    );

    initial begin
        $display("Time | Rin Gin Bin Bright || Rout Gout Bout");
        $display("-------------------------------------------");

        // case 1: mid values, no brightness
        red_in = 4'd5; green_in = 4'd6; blue_in = 4'd3; bright = 4'd0;
        #10 $display("%0t |  %0d   %0d   %0d   %0d  ||  %0d   %0d   %0d", $time, red_in, green_in, blue_in, bright, red_out, green_out, blue_out);

        // case 2: add brightness (no clamp)
        bright = 4'd3; #10 $display("%0t |  %0d   %0d   %0d   %0d  ||  %0d   %0d   %0d", $time, red_in, green_in, blue_in, bright, red_out, green_out, blue_out);

        // case 3: clamp test
        red_in = 4'd14; green_in = 4'd13; blue_in = 4'd15; bright = 4'd3; #10 $display("%0t |  %0d   %0d   %0d   %0d  ||  %0d   %0d   %0d", $time, red_in, green_in, blue_in, bright, red_out, green_out, blue_out);

        // case 4: zero inputs, large bright
        red_in = 4'd0; green_in = 4'd0; blue_in = 4'd1; bright = 4'd7; #10 $display("%0t |  %0d   %0d   %0d   %0d  ||  %0d   %0d   %0d", $time, red_in, green_in, blue_in, bright, red_out, green_out, blue_out);

        $display("TB done.");
        $finish;
    end

endmodule