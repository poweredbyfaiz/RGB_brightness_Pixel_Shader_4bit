// pixel_shader_4bit.v
// Simple 4-bit per-channel pixel shader (brightness adjust + clamp)
// Author: Faiz Ur Rahman (polished for GitHub)
// Target: Basys 3 (demo-friendly 4-bit inputs via switches)

module pixel_shader_4bit(
    input  wire [3:0] red_in,    // 4-bit red input
    input  wire [3:0] green_in,  // 4-bit green input
    input  wire [3:0] blue_in,   // 4-bit blue input
    input  wire [3:0] bright,    // 4-bit brightness adjustment
    output reg  [3:0] red_out,   // 4-bit red output (post-adjust)
    output reg  [3:0] green_out, // 4-bit green output
    output reg  [3:0] blue_out   // 4-bit blue output
);

    // Make temps one bit wider to safely hold addition results
    reg [4:0] r_sum;
    reg [4:0] g_sum;
    reg [4:0] b_sum;

    always @(*) begin
        // compute adjusted values
        r_sum = red_in   + bright;
        g_sum = green_in + bright;
        b_sum = blue_in  + bright;

        // clamp to 4-bit maximum (15)
        red_out   = (r_sum > 5'd15) ? 4'd15 : r_sum[3:0];
        green_out = (g_sum > 5'd15) ? 4'd15 : g_sum[3:0];
        blue_out  = (b_sum > 5'd15) ? 4'd15 : b_sum[3:0];
    end

endmodule