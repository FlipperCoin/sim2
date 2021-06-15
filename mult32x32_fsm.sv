// 32X32 Multiplier FSM
module mult32x32_fsm (
    input logic clk,              // Clock
    input logic reset,            // Reset
    input logic start,            // Start signal
    output logic busy,            // Multiplier busy indication
    output logic [1:0] a_sel,     // Select one byte from A
    output logic b_sel,           // Select one 2-byte word from B
    output logic [2:0] shift_sel, // Select output from shifters
    output logic upd_prod,        // Update the product register
    output logic clr_prod         // Clear the product register
);

// Put your code here
// ------------------

typedef enum {idle, clr, A0B0, A1B0, A2B0, A3B0, A0B1, A1B1, A2B1} sm_type;
sm_type current_state, next_state;

always_ff @(posedge clk, posedge reset) begin
    if (reset == 1'b1) begin
        current_state <= idle;
    end
    else begin
        current_state <= next_state;
    end 
end

always_comb begin
    busy = 1'b1;
    a_sel = 2'b00;
    b_sel = 1'b0;
    shift_sel = 3'b000;
    upd_prod = 1'b1;
    clr_prod = 1'b0;

    case (current_state)
        idle: begin
            if (start == 1'b1) begin
                clr_prod = 1'b1;
                next_state = clr;            
                busy = 1'b0;
            end
            else begin
                busy = 1'b0;
                upd_prod = 1'b0;
            end
        end
        clr: begin
            next_state = A0B0;
        end
        A0B0: begin
            next_state = A1B0;
            shift_sel=3'b001;
            a_sel=2'b01;
        end
        A1B0: begin
            next_state = A2B0;
            shift_sel=3'b010;
            a_sel=2'b10;
        end
        A2B0: begin
            next_state = A3B0;
            shift_sel=3'b011;
            a_sel=2'b11;
        end
        A3B0: begin
            next_state = A0B1;
            shift_sel=3'b010;
            b_sel=1'b1;
        end
        A0B1: begin
            next_state = A1B1;
            shift_sel = 3'b011;
            a_sel = 2'b01;
            b_sel=1'b1;
        end
        A1B1: begin
            next_state = A2B1;
            shift_sel=3'b100;
            a_sel=2'b10;
            b_sel=1'b1;
        end
        A2B1: begin
            next_state = idle;
            shift_sel=3'b101;
            a_sel=2'b11;
            b_sel=1'b1;
        end
    endcase    
end



// End of your code

endmodule
