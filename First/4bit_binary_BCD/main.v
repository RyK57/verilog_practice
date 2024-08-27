module binary_to_bcd (
    input [3:0] bin,
    output reg [6:0] bcd
);

    always @(*) begin
        case (bin)
            4'b0000: bcd = 7'b0000000;
            4'b0001: bcd = 7'b0000001;
            4'b0010: bcd = 7'b0000010;
            // add more cases for the remaining binary values
            default: bcd = 7'b1111111; // error state
        endcase
    end

endmodule

module binary_to_bcd_tb;

    reg [3:0] bin;
    wire [6:0] bcd;

    binary_to_bcd uut (
        .bin(bin),
        .bcd(bcd)
    );

    initial begin
        $dumpfile("main.vcd");
        $display("bin\tbcd");
        for (bin = 0; bin <= 15; bin = bin + 1) begin
            #10 $display("%b\t%b", bin, bcd);
        end
        $finish;
    end

endmodule
