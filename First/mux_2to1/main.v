module mux_2to1 (
    input wire a,
    input wire b,
    input wire sel,
    output wire out
);

    assign out = sel ? b : a;

endmodule

module testbench;
    reg a, b, sel;
    wire out;

    mux_2to1 uut (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin
        $dumpfile("main.vcd");
        $dumpvars(0, testbench);

        a = 0; b = 1; sel = 0;
        #10 sel = 1;
        #10 a = 1; b = 0; sel = 0;
        #10 sel = 1;
        #10 $finish;
    end

    initial begin
        $monitor("Time=%0t a=%b b=%b sel=%b out=%b", $time, a, b, sel, out);
    end

endmodule
