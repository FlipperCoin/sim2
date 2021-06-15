// 32X32 Multiplier test template
module mult32x32_fast_test_full;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product

// Put your code here
// ------------------
    mult32x32_fast m32(.clk(clk),.reset(reset),.start(start),.a(a),.b(b),.busy(busy),.product(product));

    always begin
        #10 clk = ~clk;
    end

    initial begin
        clk = 1'b0;
        start = 1'b0;

        reset = 1'b1;
        repeat(4) begin
            @(posedge clk);
        end
        reset = 1'b0;

        a = 32'd208447599;
        b = 32'd305014243;
        
        @(posedge clk);

        start = 1'b1;

        @(posedge clk);

        start = 1'b0;

        while(busy == 1'b0) begin
            @(posedge clk);
        end
        while(busy == 1'b1) begin
            @(posedge clk);
        end

        @(posedge clk);

        // TODO
        a = 32'b1010100001101111;
        b = 32'b0010010111100011;
        
        @(posedge clk);

        start = 1'b1;

        @(posedge clk);

        start = 1'b0;

        while(busy == 1'b0) begin
            @(posedge clk);
        end
        while (busy == 1'b1) begin
            @(posedge clk);
        end


        @(posedge clk);

        // TODO
        a = 32'b011011001010100001101111;
        b = 32'b0010010111100011;
        
        @(posedge clk);

        start = 1'b1;

        @(posedge clk);

        start = 1'b0;
        
        while(busy == 1'b0) begin
            @(posedge clk);
        end
        while (busy == 1'b1) begin
            @(posedge clk);
        end


        @(posedge clk);

        // TODO
        a = 32'b011011001010100001101111;
        b = 32'b00010010001011100010010111100011;
        
        @(posedge clk);

        start = 1'b1;

        @(posedge clk);

        start = 1'b0;

        while(busy == 1'b0) begin
            @(posedge clk);
        end
        while (busy == 1'b1) begin
            @(posedge clk);
        end


        @(posedge clk);

        // TODO
        a = 32'b00001100011011001010100001101111;
        b = 32'b0010010111100011;
        
        @(posedge clk);

        start = 1'b1;

        @(posedge clk);

        start = 1'b0;

        while(busy == 1'b0) begin
            @(posedge clk);
        end
        while (busy == 1'b1) begin
            @(posedge clk);
        end

    end

// End of your code

endmodule
