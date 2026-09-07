
`timescale 1ns/1ps

module digital_queue_tb;

    reg clk;
    reg reset;

    reg enqueue;
    reg dequeue;

    reg [7:0] data_in;
    wire [7:0] data_out;

    wire full;
    wire empty;
    wire [4:0] count;

    digital_queue uut (
        .clk(clk),
        .reset(reset),
        .enqueue(enqueue),
        .dequeue(dequeue),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty),
        .count(count)
    );

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin

        reset   = 1'b1;
        enqueue = 1'b0;
        dequeue = 1'b0;
        data_in = 8'd0;

        #20;

        reset = 1'b0;

        // ENQUEUE 10
        data_in = 8'd10;
        enqueue = 1'b1;
        #10;
        enqueue = 1'b0;
        #10;

        // ENQUEUE 20
        data_in = 8'd20;
        enqueue = 1'b1;
        #10;
        enqueue = 1'b0;
        #10;

        // ENQUEUE 30
        data_in = 8'd30;
        enqueue = 1'b1;
        #10;
        enqueue = 1'b0;
        #10;

        // DEQUEUE -> expected 10
        dequeue = 1'b1;
        #10;
        dequeue = 1'b0;
        #10;

        // DEQUEUE -> expected 20
        dequeue = 1'b1;
        #10;
        dequeue = 1'b0;
        #10;

        // DEQUEUE -> expected 30
        dequeue = 1'b1;
        #10;
        dequeue = 1'b0;
        #10;

        // Finish simulation
        $stop;

    end

endmodule
