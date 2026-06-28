// ============================================================
// Testbench — Round Robin Arbiter
// VLSI Open Ended Lab — EL-408
// NED University of Engineering and Technology
// Simulated in ModelSim
// ============================================================

`timescale 1ns/1ps

module tb_round_robin_arbiter();

    reg        clk;     // Clock
    reg        rst;     // Reset
    reg  [3:0] req;     // Request inputs
    wire [3:0] grant;   // Grant outputs

    // Instantiate the arbiter module
    round_robin_arbiter uut (
        .clk   (clk),
        .rst   (rst),
        .req   (req),
        .grant (grant)
    );

    // Generate clock — 10ns period (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle every 5ns
    end

    // Apply test stimulus
    initial begin
        // ---- Test 1: Reset ----
        rst = 1;
        req = 4'b0000;      // No requests during reset
        #10;

        // ---- Test 2: All requests active ----
        rst = 0;
        req = 4'b1111;      // REQ0, REQ1, REQ2, REQ3 all active
        #200;               // Watch round-robin rotation

        // ---- Test 3: Only REQ0 and REQ3 active ----
        req = 4'b1001;
        #100;

        // ---- Test 4: Only REQ2 active ----
        req = 4'b0100;
        #100;

        // ---- End simulation ----
        $stop;
    end

    // Optional: monitor output in transcript
    initial begin
        $monitor("Time=%0t | RST=%b | REQ=%b | GRANT=%b",
                  $time, rst, req, grant);
    end

endmodule
