module adder_2bit (
    input [1:0] A,
    input [1:0] B,
    output [2:0] Sum,
    output Carry
);

    assign {Carry, Sum[1:0]} = A + B;
    assign Sum[2] = Carry;

endmodule


module adder_2bit_tb;

    reg [1:0] A, B;
    wire [2:0] Sum;
    wire Carry;

    adder_2bit uut (
        .A(A),
        .B(B),
        .Sum(Sum),
        .Carry(Carry)
    );

    initial begin
        $dumpfile("main.vcd");
        $display("A\tB\tSum\tCarry");
        for (A = 0; A <= 3; A = A + 1) begin
            for (B = 0; B <= 3; B = B + 1) begin
                #10 $display("%b\t%b\t%b\t%b", A, B, Sum, Carry);
            end
        end
        $finish;
    end

endmodule

