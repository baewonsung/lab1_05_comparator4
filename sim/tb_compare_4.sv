`timescale 1ns/1ps
`default_nettype none

module tb_compare_4;
    logic [3:0] a;
    logic [3:0] b;
    wire  [2:0] o;

    integer n;
    integer checked;
    logic [2:0] expected;

    compare_4 dut (.a(a), .b(b), .o(o));

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_compare_4);
        a = 4'd0;
        b = 4'd0;
        checked = 0;

        // a changes every 16 cases and b changes every case.
        // This matches the example intervals in the LAB1-05 handout.
        for (n = 0; n < 256; n = n + 1) begin
            a = n / 16;
            b = n % 16;
            expected = {
                (n / 16) > (n % 16),
                (n / 16) == (n % 16),
                (n / 16) < (n % 16)
            };
            #10;
            if (o !== expected)
                $fatal(1,
                    "LAB1_FAIL compare_4 case=%0d a=%0h b=%0h expected=%03b actual=%03b",
                    n, a, b, expected, o);
            checked = checked + 1;
        end

        if (checked != 256)
            $fatal(1, "LAB1_FAIL compare_4 checked=%0d expected_cases=256", checked);
        $display("LAB1_PASS compare_4 cases=%0d", checked);
        $finish;
    end

    initial begin
        #3000;
        $fatal(1, "LAB1_FAIL compare_4 watchdog timeout");
    end
endmodule

`default_nettype wire
