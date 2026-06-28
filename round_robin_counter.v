// Round Robin Counter Module
// Counts from 0 to N-1 and repeats (wraps around)

module round_robin_counter #(parameter N = 4) (
    input        clk,       // Clock input
    input        rst,       // Reset input (active-high)
    output reg [1:0] count  // 2-bit counter output (0 to N-1)
);

    // Count increases on each rising clock edge
    // Resets to 0 when rst = 1
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 0;           // Reset count to 0
        else
            count <= (count + 1) % N; // Increment, wrap after N
    end

endmodule
