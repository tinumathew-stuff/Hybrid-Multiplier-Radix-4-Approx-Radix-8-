module myhlr(
    input [15:0] A,
    input [15:0] B,
    output wire [31:0] result
);


    wire [15:0] pp0, pp1, pp2, pp3, pp4, pp5;
    wire [5:0] spp;

    approx2rad8siggen row0(A[2], A[1], A[0], 1'b0, B, pp0, spp[0]);
    approx2rad8siggen row1(A[5], A[4], A[3], A[2], B, pp1, spp[1]);
    approx2rad8siggen row2(A[8], A[7], A[6], A[5], B, pp2, spp[2]);
    approx2rad8siggen row3(A[11], A[10], A[9], A[8], B, pp3, spp[3]);

    rad4siggen row4(A[13], A[12], A[11], B, pp4, spp[4]);
    rad4siggen row5(A[15], A[14], A[13], B, pp5, spp[5]);

    wire carry[26:0];
    wire resultinb[26:9];
    wire carryinb[30:9];
    wire resultinbb[26:4];
    wire cout1[19:0];
    wire carryinbb[22:0];

    HA res0(pp0[0], spp[0], result[0], carry[0]);
    HA res1(pp0[1], carry[0], result[1], carry[1]);
    HA res2(pp0[2], carry[1], result[2], carry[2]);
    fourto2compress res3(.A(pp0[3]), .B(pp1[0]), .C(spp[1]), .D(1'b0), .Cin(carry[2]), .sum(result[3]), .carry(carry[3]),.cout(cout1[0]));
    FA nores4(pp0[4], pp1[1], carry[3], resultinbb[4], carry[4]);
    FA nores5(pp0[5], pp1[2], carry[4], resultinbb[5], carry[5]);
    fourto2compress res6(.A(pp0[6]), .B(pp1[3]), .C(pp2[0]), .D(spp[2]), .Cin(carry[5]), .sum(resultinbb[6]), .carry(carry[6]),.cout(cout1[3]));
    fourto2compress res7(.A(pp0[7]), .B(pp1[4]), .C(pp2[1]), .D(1'b0), .Cin(carry[6]), .sum(resultinbb[7]), .carry(carry[7]),.cout(cout1[4]));
    fourto2compress res8(.A(pp0[8]), .B(pp1[5]), .C(pp2[2]), .D(1'b0), .Cin(carry[7]), .sum(resultinbb[8]), .carry(carry[8]),.cout(cout1[5]));
    fourto2compress nores9(.A(pp0[9]), .B(pp1[6]), .C(pp2[3]), .D(pp3[0]), .Cin(carry[8]), .sum(resultinbb[9]), .carry(carry[9]),.cout(cout1[6]));
    fourto2compress nores10(.A(pp0[10]), .B(pp1[7]), .C(pp2[4]), .D(pp3[1]), .Cin(carry[9]), .sum(resultinbb[10]), .carry(carry[10]),.cout(cout1[7]));
    fourto2compress nores11(.A(pp0[11]), .B(pp1[8]), .C(pp2[5]), .D(pp3[2]), .Cin(carry[10]), .sum(resultinbb[11]), .carry(carry[11]),.cout(cout1[8]));
    fourto2compress nores12(.A(pp0[12]), .B(pp1[9]), .C(pp2[6]), .D(pp3[3]), .Cin(carry[11]), .sum(resultinbb[12]), .carry(carry[12]),.cout(cout1[9]));
    fourto2compress nores13(.A(pp0[13]), .B(pp1[10]), .C(pp2[7]), .D(pp3[4]), .Cin(carry[12]), .sum(resultinbb[13]), .carry(carry[13]),.cout(cout1[10]));
    fourto2compress nores14(.A(pp0[14]), .B(pp1[11]), .C(pp2[8]), .D(pp3[5]), .Cin(carry[13]), .sum(resultinbb[14]), .carry(carry[14]),.cout(cout1[11]));
    fourto2compress nores15(.A(pp0[15]), .B(pp1[12]), .C(pp2[9]), .D(pp3[6]), .Cin(carry[14]), .sum(resultinbb[15]), .carry(carry[15]),.cout(cout1[12]));
    fourto2compress nores16(.A(pp0[15]), .B(pp1[13]), .C(pp2[10]), .D(pp3[7]), .Cin(carry[15]), .sum(resultinbb[16]), .carry(carry[16]),.cout(cout1[13]));
    fourto2compress nores17(.A(spp[0]), .B(pp1[14]), .C(pp2[11]), .D(pp3[8]), .Cin(carry[16]), .sum(resultinbb[17]), .carry(carry[17]),.cout(cout1[14]));
    fourto2compress nores18(.A(spp[0]), .B(pp1[15]), .C(pp2[12]), .D(pp3[9]), .Cin(carry[17]), .sum(resultinbb[18]), .carry(carry[18]),.cout(cout1[15]));
    fourto2compress nores19(.A(spp[0]), .B(pp1[15]), .C(pp2[13]), .D(pp3[10]), .Cin(carry[18]), .sum(resultinbb[19]), .carry(carry[19]),.cout(cout1[16]));
    fourto2compress nores20(.A((spp[0])), .B((spp[1])), .C(pp2[14]), .D(pp3[11]), .Cin(carry[19]), .sum(resultinbb[20]), .carry(carry[20]),.cout(cout1[17]));
    fourto2compress nores21( .A(1'b0),.B(1'b1), .C(pp2[15]), .D(pp3[12]), .Cin(carry[20]), .sum(resultinbb[21]), .carry(carry[21]),.cout(cout1[18]));
    fourto2compress nores22( .A(1'b0),.B(1'b1), .C(pp2[15]), .D(pp3[13]), .Cin(carry[21]), .sum(resultinbb[22]), .carry(carry[22]),.cout(cout1[19]));
    FA nores23(~(spp[2]), pp3[14], carry[22], resultinbb[23], carry[23]);
    FA nores24(1'b1, pp3[15], carry[23], resultinbb[24], carry[24]);
    FA nores25(1'b1, pp3[15], carry[24], resultinbb[25], carry[25]);
    HA nores26(~(spp[3]), carry[25], resultinbb[26], carry[26]);

    FA res4(resultinbb[4],cout1[0],1'b0,result[4],carryinbb[0]);
    FA res5(resultinbb[5],1'b0,carryinbb[0],result[5],carryinbb[1]);
    FA hares6(resultinbb[6],carryinbb[1],1'b0,result[6],carryinbb[2]);
    FA hares7(resultinbb[7],carryinbb[2],cout1[3],result[7],carryinbb[3]);
    FA hares8(resultinbb[8],carryinbb[3],cout1[4],result[8],carryinbb[4]);
    FA hares9(resultinbb[9],carryinbb[4],cout1[5],resultinb[9],carryinbb[5]);
    FA hares10(resultinbb[10],carryinbb[5],cout1[6],resultinb[10],carryinbb[6]);
    FA hares11(resultinbb[11],carryinbb[6],cout1[7],resultinb[11],carryinbb[7]);
    FA hares12(resultinbb[12],carryinbb[7],cout1[8],resultinb[12],carryinbb[8]);
    FA hares13(resultinbb[13],carryinbb[8],cout1[9],resultinb[13],carryinbb[9]);
    FA hares14(resultinbb[14],carryinbb[9],cout1[10],resultinb[14],carryinbb[10]);
    FA hares15(resultinbb[15],carryinbb[10],cout1[11],resultinb[15],carryinbb[11]);
    FA hares16(resultinbb[16],carryinbb[11],cout1[12],resultinb[16],carryinbb[12]);
    FA hares17(resultinbb[17],carryinbb[12],cout1[13],resultinb[17],carryinbb[13]);
    FA hares18(resultinbb[18],carryinbb[13],cout1[14],resultinb[18],carryinbb[14]);
    FA hares19(resultinbb[19],carryinbb[14],cout1[15],resultinb[19],carryinbb[15]);
    FA hares20(resultinbb[20],carryinbb[15],cout1[16],resultinb[20],carryinbb[16]);
    FA hares21(resultinbb[21],carryinbb[16],cout1[17],resultinb[21],carryinbb[17]);
    FA hares22(resultinbb[22],carryinbb[17],cout1[18],resultinb[22],carryinbb[18]);
    FA hares23(resultinbb[23],carryinbb[18],cout1[19],resultinb[23],carryinbb[19]);
    FA hares24(resultinbb[24],carryinbb[19],1'b0,resultinb[24],carryinbb[20]);
    FA hares25(resultinbb[25],carryinbb[20],1'b0,resultinb[25],carryinbb[21]);
    FA hares26(resultinbb[26],carryinbb[21],1'b0,resultinb[26],carryinbb[22]);

    wire cout2[15:0];



    wire resultinbbb,carryinbbb;


    HA res9(resultinb[9], spp[3], result[9], carryinb[9]);
    HA res10(resultinb[10], carryinb[9], result[10], carryinb[10]);
    FA res11(resultinb[11], spp[4], carryinb[10], result[11], carryinb[11]);
    FA res12(resultinb[12], pp4[0], carryinb[11], result[12], carryinb[12]);
    fourto2compress res13(.A(resultinb[13]), .B(pp4[1]), .C(spp[5]), .D(1'b0), .Cin(carryinb[12]), .sum(result[13]), .carry(carryinb[13]),.cout(cout2[0]));
    fourto2compress res14(.A(resultinb[14]), .B(pp4[2]), .C(pp5[0]), .D(cout2[0]), .Cin(carryinb[13]), .sum(result[14]), .carry(carryinb[14]),.cout(cout2[1]));
    fourto2compress res15(.A(resultinb[15]), .B(pp4[3]), .C(pp5[1]), .D(cout2[1]), .Cin(carryinb[14]), .sum(result[15]), .carry(carryinb[15]),.cout(cout2[2]));
    fourto2compress res16(.A(resultinb[16]), .B(pp4[4]), .C(pp5[2]), .D(cout2[2]), .Cin(carryinb[15]), .sum(result[16]), .carry(carryinb[16]),.cout(cout2[3]));
    fourto2compress res17(.A(resultinb[17]), .B(pp4[5]), .C(pp5[3]), .D(cout2[3]), .Cin(carryinb[16]), .sum(result[17]), .carry(carryinb[17]),.cout(cout2[4]));
    fourto2compress res18(.A(resultinb[18]), .B(pp4[6]), .C(pp5[4]), .D(cout2[4]), .Cin(carryinb[17]), .sum(result[18]), .carry(carryinb[18]),.cout(cout2[5]));
    fourto2compress res19(.A(resultinb[19]), .B(pp4[7]), .C(pp5[5]), .D(cout2[5]), .Cin(carryinb[18]), .sum(result[19]), .carry(carryinb[19]),.cout(cout2[6]));
    fourto2compress res20(.A(resultinb[20]), .B(pp4[8]), .C(pp5[6]), .D(cout2[6]), .Cin(carryinb[19]), .sum(result[20]), .carry(carryinb[20]),.cout(cout2[7]));
    fourto2compress res21(.A(resultinb[21]), .B(pp4[9]), .C(pp5[7]), .D(cout2[7]), .Cin(carryinb[20]), .sum(result[21]), .carry(carryinb[21]),.cout(cout2[8]));
    fourto2compress res22(.A(resultinb[22]), .B(pp4[10]), .C(pp5[8]), .D(cout2[8]), .Cin(carryinb[21]), .sum(result[22]), .carry(carryinb[22]),.cout(cout2[9]));
    fourto2compress res23(.A(resultinb[23]), .B(pp4[11]), .C(pp5[9]), .D(cout2[9]), .Cin(carryinb[22]), .sum(result[23]), .carry(carryinb[23]),.cout(cout2[10]));
    fourto2compress res24(.A(resultinb[24]), .B(pp4[12]), .C(pp5[10]), .D(cout2[10]), .Cin(carryinb[23]), .sum(result[24]), .carry(carryinb[24]),.cout(cout2[11]));
    fourto2compress res25(.A(resultinb[25]), .B(pp4[13]), .C(pp5[11]), .D(cout2[11]), .Cin(carryinb[24]), .sum(result[25]), .carry(carryinb[25]),.cout(cout2[12]));
    fourto2compress res26(.A(resultinb[26]), .B(pp4[14]), .C(pp5[12]), .D(cout2[12]), .Cin(carryinb[25]), .sum(result[26]), .carry(carryinb[26]),.cout(cout2[13]));
    
    fourto2compress nores27(.A((~spp[4])), .B(pp5[13]), .C(carryinb[26]), .D(carry[26]), .Cin(carryinbb[22]), .sum(resultinbbb), .carry(carryinb[27]),.cout(cout2[14]));
    HA res27(resultinbbb,cout2[13],result[27],carryinbbb);
    
    
    
    fourto2compress res28(.A(1'b1), .B(pp5[14]), .C(carryinbbb), .D(cout2[14]), .Cin(1'b0), .sum(result[28]), .carry(carryinb[28]),.cout(cout2[15]));

    
    
    FA res29(carryinb[28], (~spp[5]),cout2[15], result[29], carryinb[29]);
    HA res30(1'b1, carryinb[29],result[30], carryinb[30]);
    assign result[31]=carryinb[30];

endmodule

module twoto1mux(input A, B, sel, output S);
    assign S = ((~sel & A) | (sel & B)); 
endmodule

module fourto2compress(
    input A, B, C, D, Cin,
    output sum, cout, carry
);
    wire w1, w2, w3;
    xor(w1, A, B);
    xor(w2, C, D);
    twoto1mux mux1(A, C, w1, cout);
    xor(w3, w1, w2);
    xor(sum, w3, Cin);
    twoto1mux mux2(w3, Cin, w3, carry);
endmodule

module FA (
    input a, b, cin,
    output sum, carry
);
    assign sum = a ^ b ^ cin;   
    assign carry = (a & b) | (b & cin) | (cin & a);
endmodule

module HA (
    input a, b,    
    output s, c    
);
    assign s = a ^ b;
    assign c = a & b; 
endmodule

module approx2rad8siggen(
    input A, B, C, D,
    input [15:0] NUM,
    output [15:0] pp,
    output spp
);
    wire x1 = (~A & ~B & ~C & D) | (~A & ~B & C & ~D) | (A & B & ~C & D) | (A & B & C & ~D);
    wire x2 = (~B & C & D) | (~A & B & ~C) | (B & ~C & ~D) | (A & ~B & C);
    wire x4 = (~A & B & C) | (A & ~B & ~C);
    wire s = A;
    assign spp = A;
    assign pp[0] = (((1'b0 & x4) | (1'b0 & x2) | (NUM[0] & x1)) ^ s);
    assign pp[1] = (((1'b0 & x4) | (NUM[0] & x2) | (NUM[1] & x1)) ^ s);

    genvar i;
    generate
        for (i = 2; i <= 15; i = i + 1) begin 
            assign pp[i] = (((NUM[i-2] & x4) | (NUM[i-1] & x2) | (NUM[i] & x1)) ^ s);
        end
    endgenerate
endmodule

module rad4siggen(
    input A, B, C,
    input [15:0] NUM,
    output [15:0] pp,
    output spp
);
    wire x1 = (~B & C) | (B & ~C);
    wire x2 = (~A & B & C) | (A & ~B & ~C);
    wire s = A;
    assign spp = A;
    assign pp[0] = (((1'b0 & x2) | (NUM[0] & x1)) ^ s);

    genvar j;
    generate
        for (j = 1; j <= 15; j = j + 1) begin 
            assign pp[j] = (((NUM[j-1] & x2) | (NUM[j] & x1)) ^ s);
        end
    endgenerate
endmodule
