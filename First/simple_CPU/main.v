module cpu (
    input clk,
    input reset,
    output reg [15:0] PC,
    output reg [15:0] IR,
    output reg [15:0] DR,
    output reg [15:0] memory_addr,
    input [15:0] memory_data,
    output reg [15:0] memory_out
);

    reg [1:0] state;
    parameter IDLE = 2'b00, FETCH = 2'b01, DECODE = 2'b10;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            PC <= 16'h0000;
        end else begin
            case (state)
                IDLE: begin
                    state <= FETCH;
                end
                FETCH: begin
                    memory_addr <= PC;
                    IR <= memory_data;
                    PC <= PC + 1;
                    state <= DECODE;
                end
                DECODE: begin
                    case (IR[15:12])
                        4'b0001: begin // LDI
                            DR <= IR[11:0];
                        end
                        4'b0010: begin // ADD
                            DR <= DR + IR[11:0];
                        end
                        4'b1111: begin // HLT
                            $stop;
                        end
                        default: begin // error state
                            $display("Error: invalid instruction %b", IR);
                            $stop;
                        end
                    endcase
                    state <= FETCH;
                end
            endcase
        end
    end

endmodule

module cpu_tb;

    reg clk, reset;
    wire [15:0] PC, IR, DR;
    wire [15:0] memory_data;
    wire [15:0] memory_addr;  // Changed memory_addr from reg to wire
    wire [15:0] memory_out;

    cpu uut (
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .IR(IR),
        .DR(DR),
        .memory_addr(memory_addr),  // Connecting memory_addr as wire
        .memory_data(memory_data),
        .memory_out(memory_out)
    );

    memory mem_inst (
        .clk(clk),
        .addr(memory_addr),
        .data(16'b0),
        .write_enable(1'b0),
        .q(memory_data)
    );

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("main.vcd");
        $dumpvars(0, cpu_tb);
        mem_inst.mem[0] = 16'h1005; // LDI 5
        mem_inst.mem[1] = 16'h2003; // ADD 3
        mem_inst.mem[2] = 16'hffff; // HLT
        // add more instructions as needed
    end

endmodule


module memory (
    input clk,
    input [15:0] addr,
    input [15:0] data,
    input write_enable,
    output reg [15:0] q
);

    reg [15:0] mem [0:65535];

    always @(posedge clk) begin
        if (write_enable) begin
            mem[addr] <= data;
        end
        q <= mem[addr];
    end

endmodule
