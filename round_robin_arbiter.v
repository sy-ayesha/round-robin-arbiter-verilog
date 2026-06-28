// ============================================================
// Round Robin Arbiter Module
// VLSI Open Ended Lab — EL-408
// NED University of Engineering and Technology
// ============================================================
// 4-input Round-Robin Arbiter with Fixed-Time Slice Allocation
// Each request gets TIME_SLICE clock cycles of access
// Grant output is one-hot encoded

module round_robin_arbiter #(
    parameter N          = 4,  // Number of requesters
    parameter TIME_SLICE = 4   // Clock cycles per time slice
)(
    input            clk,       // Clock input
    input            rst,       // Active-high reset
    input  [N-1:0]   req,       // N request inputs
    output reg [N-1:0] grant    // One-hot grant output
);

    reg [1:0] current;      // Current active request index
    reg [2:0] time_count;   // Time slice counter

    // Round-robin arbitration process
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Initialize on reset
            current    <= 0;
            time_count <= 0;
            grant      <= 4'b0001;  // Start with REQ0
        end
        else begin
            // If current request is still active and time slice not done
            if (req[current] && time_count < TIME_SLICE - 1) begin
                time_count <= time_count + 1;       // Continue serving same request
                grant      <= (4'b0001 << current); // Keep same grant active
            end
            else begin
                // Move to next request
                time_count <= 0;
                current    <= (current + 1) % N;

                // Find the next active request in round-robin order
                if (req[(current + 1) % N])
                    grant <= (4'b0001 << ((current + 1) % N));
                else if (req[(current + 2) % N])
                    grant <= (4'b0001 << ((current + 2) % N));
                else if (req[(current + 3) % N])
                    grant <= (4'b0001 << ((current + 3) % N));
                else
                    grant <= 4'b0000;   // No requests active
            end
        end
    end

endmodule
