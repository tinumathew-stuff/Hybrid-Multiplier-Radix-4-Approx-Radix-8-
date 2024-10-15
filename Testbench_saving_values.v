module tb(
    input [31:0] result,
    output reg [15:0] A,
    output reg [15:0] B
);
    integer i,j;
    integer file;  // File descriptor for the output file

    myhlr uut (
        .A(A),
        .B(B),
        .result(result)
    );
    initial begin
        A = 16'b0;
        B = 16'b0;
        file = $fopen("output.txt", "w");


        for (i = 0; i <= 10000; i = i + 1) begin
            A = A + 1;
        for (j = 0; j <= 10000; j = j + 1) begin
            B = B + 1;
        end
$fdisplay(file,result);

        #1;
        end
        
    end

endmodule
