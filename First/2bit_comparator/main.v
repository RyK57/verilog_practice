module comparator_2bit (
    input [1:0] A,
    input [1:0] B,
    output EQ,
    output LT,
    output GT
);

    assign EQ = (A == B);
    assign LT = (A < B);
    assign GT = (A > B);

endmodule

module comparator_2bit_tb;

    reg [1:0] A, B;
    wire EQ, LT, GT;

    comparator_2bit uut (
        .A(A),
        .B(B),
        .EQ(EQ),
        .LT(LT),
        .GT(GT)
    );

    initial begin
        $dumpfile("main.vcd");
        $display("A\tB\tEQ\tLT\tGT");
        for (A = 0; A <= 3; A = A + 1) begin
            for (B = 0; B <= 3; B = B + 1) begin
                #10 $display("%b\t%b\t%b\t%b\t%b", A, B, EQ, LT, GT);
            end
        end
        $finish;
    end

endmodule
