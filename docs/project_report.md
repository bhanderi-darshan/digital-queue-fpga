
# Digital Queue using Verilog HDL

## 1. Project Overview

This project implements a digital queue using Verilog HDL on an Altera Cyclone II FPGA.

The queue follows the FIFO (First-In First-Out) principle, where the first data entered into the queue is the first data removed.

## 2. Objective

The objectives of this project are:

* Design a FIFO queue using Verilog HDL.
* Store 8-bit data values.
* Support enqueue and dequeue operations.
* Detect full and empty queue conditions.
* Verify the design through simulation.
* Implement the design on an Altera Cyclone II FPGA board.

## 3. Specifications

| Parameter   | Value             |
| ----------- | ----------------- |
| FPGA        | Altera Cyclone II |
| HDL         | Verilog HDL       |
| Data Width  | 8 bits            |
| Queue Depth | 16 entries        |
| Queue Type  | FIFO              |
| Operations  | Enqueue / Dequeue |

## 4. Functional Description

### Enqueue

The enqueue operation stores `data_in` into the next available queue location.

It is performed only when the queue is not full.

### Dequeue

The dequeue operation reads the oldest stored value and places it on `data_out`.

It is performed only when the queue is not empty.

### Full

The `full` signal becomes HIGH when all 16 queue locations contain data.

### Empty

The `empty` signal becomes HIGH when the queue contains no data.

## 5. Internal Architecture

The queue uses:

* FIFO memory
* Write pointer
* Read pointer
* Element counter
* Full detection
* Empty detection

```text
              +----------------+
data_in ----->|                |
              |   FIFO MEMORY  |
enqueue ----->|                |
              +-------+--------+
                      |
                      v
              +---------------+
              |  READ CONTROL |
              +-------+-------+
                      |
                      v
                   data_out
```

## 6. RTL Files

### `rtl/digital_queue.v`

Contains the main FIFO queue RTL.

### `rtl/digital_queue_top.v`

Connects the FIFO design to the FPGA board inputs and outputs.

### `tb/digital_queue_tb.v`

Contains the simulation testbench.

## 7. FPGA Interface

### Inputs

| Signal  | Function          |
| ------- | ----------------- |
| CLOCK   | FPGA system clock |
| RESET   | Reset queue       |
| ENQUEUE | Insert data       |
| DEQUEUE | Remove data       |
| SW[7:0] | 8-bit input data  |

### Outputs

| Signal    | Function              |
| --------- | --------------------- |
| LED[7:0]  | Dequeued data         |
| FULL_LED  | Queue full indicator  |
| EMPTY_LED | Queue empty indicator |

## 8. Verification

The testbench verifies:

1. Reset operation
2. Enqueue operation
3. Multiple enqueue operations
4. Dequeue operation
5. FIFO ordering
6. Empty condition
7. Full condition
8. Queue boundary conditions

## 9. Expected FIFO Behavior

If the following values are inserted:

```text
10
20
30
```

The dequeue sequence must be:

```text
10
20
30
```

This confirms FIFO operation.

## 10. Final Goal

The final implementation will demonstrate a working digital FIFO queue on the Altera Cyclone II FPGA board using Verilog HDL.
