module digital_queue #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 16
)(
    input  wire                  clk,
    input  wire                  reset,

    input  wire                  enqueue,
    input  wire                  dequeue,

    input  wire [DATA_WIDTH-1:0] data_in,
    output reg  [DATA_WIDTH-1:0] data_out,

    output wire                  full,
    output wire                  empty,
    output wire [4:0]            count
);

    reg [DATA_WIDTH-1:0] memory [0:DEPTH-1];

    reg [3:0] write_pointer;
    reg [3:0] read_pointer;
    reg [4:0] count_reg;

    assign count = count_reg;

    assign empty = (count_reg == 5'd0);
    assign full  = (count_reg == DEPTH);

    always @(posedge clk) begin

        if (reset) begin

            write_pointer <= 4'd0;
            read_pointer  <= 4'd0;
            count_reg     <= 5'd0;
            data_out      <= 8'd0;

        end
        else begin

            // ENQUEUE only
            if (enqueue && !dequeue && !full) begin

                memory[write_pointer] <= data_in;
                write_pointer <= write_pointer + 1'b1;
                count_reg <= count_reg + 1'b1;

            end

            // DEQUEUE only
            else if (dequeue && !enqueue && !empty) begin

                data_out <= memory[read_pointer];
                read_pointer <= read_pointer + 1'b1;
                count_reg <= count_reg - 1'b1;

            end

            // ENQUEUE and DEQUEUE together
            else if (enqueue && dequeue) begin

                if (!full && !empty) begin

                    memory[write_pointer] <= data_in;
                    write_pointer <= write_pointer + 1'b1;

                    data_out <= memory[read_pointer];
                    read_pointer <= read_pointer + 1'b1;

                end

            end

        end

    end

endmodule
