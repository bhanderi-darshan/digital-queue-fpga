module digital_queue_top (
    input  wire       CLOCK,
    input  wire       RESET,
    input  wire       ENQUEUE,
    input  wire       DEQUEUE,

    input  wire [7:0] SW,

    output wire [7:0] LED,
    output wire       FULL_LED,
    output wire       EMPTY_LED
);

    wire [7:0] data_out;
    wire       full;
    wire       empty;
    wire [4:0] count;

    digital_queue #(
        .DATA_WIDTH(8),
        .DEPTH(16)
    ) queue_inst (
        .clk       (CLOCK),
        .reset     (RESET),
        .enqueue   (ENQUEUE),
        .dequeue   (DEQUEUE),
        .data_in   (SW),
        .data_out  (data_out),
        .full      (full),
        .empty     (empty),
        .count     (count)
    );

    assign LED       = data_out;
    assign FULL_LED  = full;
    assign EMPTY_LED = empty;

endmodule
