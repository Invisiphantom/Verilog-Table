// (J=0 && K=0) hold
// (J=1 && K=0) set
// (J=0 && K=1) reset
// (J=1 && K=1) toggle
module JK_Flipflop (
    input  J,
    input  K,
    input  clk,
    output reg Q,
    output reg Q_bar
);
    initial begin
        Q <= 1;
        Q_bar <= 0;
    end

    wire _Q, _Q_bar;
    wire J_bar, K_bar, D;
    assign J_bar = J & Q_bar; // (J=1) if ans=0 then (J_bar=1)
    assign K_bar = ~K & Q;    // (K=0) if ans=1 then (K_bar=1)
    assign D = J_bar | K_bar; // D = J*~D + ~K&D 
    D_Flipflop u_D_Flipflop(
    	.D     (D     ),
        .clk   (clk   ),
        .Q     (_Q     ),
        .Q_bar (_Q_bar )
    );
    always @(*) begin
        Q <= _Q;
        Q_bar <= _Q_bar;
    end
endmodule



module JK_Flipflop_tb;
    reg J, K, clk;
    wire Q, Q_bar;
    JK_Flipflop JK_Flipflop_0(J, K, clk, Q, Q_bar);
    
    initial begin
        $dumpfile("JK_Flipflop.vcd");
        $dumpvars(1, JK_Flipflop_tb);
        $display("J K clk | Q Q_bar");
        $monitor("%b %b   %b | %b %b", J, K, clk, Q, Q_bar);
        J = 0; K = 0; clk = 0;
        #10 J = 1; K = 0; clk = 0;
        #10 J = 1; K = 0; clk = 1;
        #10 J = 1; K = 0; clk = 0;

        #10 J = 0; K = 1; clk = 0;
        #10 J = 0; K = 1; clk = 1;
        #10 J = 0; K = 1; clk = 0;

        #10 J = 1; K = 1; clk = 0;
        #10 J = 1; K = 1; clk = 1;
        #10 J = 1; K = 1; clk = 0;
        #10 J = 1; K = 1; clk = 1;
        #10 J = 1; K = 1; clk = 0;
        #10 J = 1; K = 1; clk = 1;
        #10 J = 1; K = 1; clk = 0;
    end
endmodule