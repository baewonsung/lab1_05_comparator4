`default_nettype none

module compare_4 (
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire [2:0] o
);
    // o[2]: a > b, o[1]: a == b, o[0]: a < b
    assign o = {a > b, a == b, a < b};
endmodule

`default_nettype wire
