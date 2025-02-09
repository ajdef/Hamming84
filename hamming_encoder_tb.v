`timescale 1ns / 1ps
/*
*   8,4 Hamming Encoder Testbench
*   Module by Alexander DeFalco
*   February 2025
*/
module hamming_encoder_tb();
    reg [3:0] data;
    wire [7:0] encoded;
    integer i, incorrect_enc, correct_enc;
    
    hamming_encoder DUT(.data(data), .encoded(encoded));    
    
    initial begin
    correct_enc = 0;
    incorrect_enc = 0;
        for(i = 0; i < 16; i= i + 1) begin
            data = i;
            #5; //wait 5ns, post-data assignment to avoid null value at start of sim
            verifyResult(data, encoded);
        end
        $display("%d SUCCESSFUL ENCODINGS \t %d FAILED ENCODINGS", correct_enc, incorrect_enc);
        $finish;
    end

//P_DDD_P_D_PP
//p3 d3 d2 d1 p2 d0 p1 p0
    task verifyResult(  input [3:0] data,
                        input [7:0] encoded
                        );
        reg [7:0] expected; //used to store desired value of encoding, then compare to actual
        begin
            case(data)
                4'b0000:    expected = 8'b0_000_0_0_00;
                4'b0001:    expected = 8'b1_000_0_1_11;
                4'b0010:    expected = 8'b1_001_1_0_01;
                4'b0011:    expected = 8'b0_001_1_1_10;
                4'b0100:    expected = 8'b1_010_1_0_10;
                4'b0101:    expected = 8'b0_010_1_1_01;
                4'b0110:    expected = 8'b0_011_0_0_11;
                4'b0111:    expected = 8'b1_011_0_1_00;
                4'b1000:    expected = 8'b0_100_1_0_11;
                4'b1001:    expected = 8'b1_100_1_1_00;
                4'b1010:    expected = 8'b1_101_0_0_10;
                4'b1011:    expected = 8'b0_101_0_1_01;
                4'b1100:    expected = 8'b1_110_0_0_01;
                4'b1101:    expected = 8'b0_110_0_1_10;
                4'b1110:    expected = 8'b0_111_1_0_00;
                4'b1111:    expected = 8'b1_111_1_1_11;
            endcase
            
            if (encoded == expected) begin
                $display("Successful Encoding for \tinput %b and output %b", data, encoded);
                correct_enc = correct_enc + 1;
            end else begin
                $display("Failed encoding for \tinput %b, \tEXPECTED: %b, \tACTUAL: %b", data, expected, encoded);
                incorrect_enc = incorrect_enc + 1;
            end
        end
    endtask
endmodule