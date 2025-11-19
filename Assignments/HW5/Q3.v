module button_sync (
    input  wire clk,
    input  wire rst,
    input  wire bi,
    output reg  bo
);

    localparam A_IDLE        = 2'b00;
    localparam B_PULSE       = 2'b01;
    localparam C_BUTTON_HOLD = 2'b10;

    reg [1:0] state, state_next;

    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= A_IDLE;
        else
            state <= state_next;
    end

    always @(*) begin
        case (state)
            A_IDLE:
                state_next = bi ? B_PULSE : A_IDLE;

            B_PULSE:
                state_next = bi ? C_BUTTON_HOLD : A_IDLE;

            C_BUTTON_HOLD:
                state_next = bi ? C_BUTTON_HOLD : A_IDLE;

            default:
                state_next = A_IDLE;
        endcase
    end

    always @(*) begin
        bo = (state == B_PULSE);
    end

endmodule
