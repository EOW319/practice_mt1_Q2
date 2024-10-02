module task2 (
    input clk,
    input resetb,    // active low reset
    input start,
    input [7:0] N,   // 8-bit input N
    output reg [7:0] R, // 8-bit output R
    output reg done,
    output reg [2:0] state,
    output [7:0] tag
);

    assign tag = 8'hFE; // DO NOT CHANGE THIS

    // State encoding
    localparam IDLE      = 3'b000;
    localparam COMPUTE   = 3'b001;
    localparam DONE      = 3'b010;

    reg [7:0] temp_N;   // Temporary storage for N
    reg [7:0] count;     // Count of shifts

    always @(posedge clk or negedge resetb) begin
        if (!resetb) begin
            R <= 0;
            done <= 0;
            state <= IDLE;
            count <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        temp_N <= N; // Store N
                        count <= 0;
                        R <= 0;
                        done <= 0;
                        state <= COMPUTE; // Move to computing state
                    end
                end
                COMPUTE: begin
                    if (temp_N > 1) begin
                        temp_N <= temp_N >> 1; // Shift right
                        count <= count + 1;     // Increment count
                        R <= count;              // Update R
                    end else begin
                        R <= count;              // Final value of R
                        done <= 1;               // Indicate done
                        state <= DONE;           // Move to done state
                    end
                end
                DONE: begin
                    // Wait for a cycle to indicate done and then reset
                    if (done) begin
                        // Allow R to stay for one additional clock cycle
                        // after the computation is finished
                        state <= IDLE; // Return to idle state
                        done <= 0;     // Reset done signal
                    end
                end
            endcase
        end
    end
endmodule
