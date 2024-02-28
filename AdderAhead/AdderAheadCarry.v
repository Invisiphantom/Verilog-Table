module AdderAheadCarry (
    input [3:0] g_i,  // generate (a & b)
    input [3:0] p_i,  // propagate (a | b)
    input cin_i,  // carry in
    output [3:0] cout_o,  // carry out
    output g4_o,  // generate 4bits
    output p4_o  // propagate 4bits
);
    // cout = a & b | a & cin | b & cin
    // cout = (a&b) | (a|b) & cin
    // cout = g1 | p1 & cin

    /* g_i[0] | p_i[0] & cin_i */
    assign cout_o[0] = g_i[0] | p_i[0] & cin_i;

    /* g_i[1] | p_i[1] & cout_o[1] */
    assign cout_o[1] = g_i[1] | p_i[1] & g_i[0] | p_i[1] & p_i[0] & cin_i;

    /* g_i[2] | p_i[2] & cout_o[2] */
    assign cout_o[2] = g_i[2] | p_i[2] & g_i[1] | p_i[2] & p_i[1] & g_i[0] | p_i[2] & p_i[1] & p_i[0] & cin_i;

    /* g_i[3] | p_i[3] & cout_o[3] */
    assign cout_o[3] = g_i[3] | p_i[3] & g_i[2] | p_i[3] & p_i[2] & g_i[1] | p_i[3] & p_i[2] & p_i[1] & g_i[0] | p_i[3] & p_i[2] & p_i[1] & p_i[0] & cin_i;

    /* cout_o[3] = g4_o | p4_o & cin_i */
    assign g4_o = g_i[3] | p_i[3] & g_i[2] | p_i[3] & p_i[2] & g_i[1] | p_i[3] & p_i[2] & p_i[1] & g_i[0];
    assign p4_o = p_i[3] & p_i[2] & p_i[1] & p_i[0];
endmodule
