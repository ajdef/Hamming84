`timescale 1ns / 1ps
/*
*   8,4 Hamming Decoder Testbench
*   Module by Alexander DeFalco
*   February 2025
*/
module hamming_decoder_tb();
    reg [7:0] encoded;
    wire [3:0] data;
    wire SEC, DED;
    integer randomMask;
    
    
    hamming_decoder DUT(.encoded(encoded),
                        .data(data),
                        .SEC(SEC),
                        .DED(DED)
                        );
    initial begin
        
        $display("\n Simulating Expected Inputs:");
        $monitor($time, " - ENCODED INPUT: %b\tPARITY BIT: %b\tOUTPUT DATA: %b\tSEC: %b\tDED: %b", encoded, encoded[7], data, SEC, DED);
        #5 encoded = 8'b0_000_0_0_00;
        #5 encoded = 8'b1_000_0_1_11;
        #5 encoded = 8'b1_001_1_0_01;
        #5 encoded = 8'b0_001_1_1_10;
        #5 encoded = 8'b1_010_1_0_10;
        #5 encoded = 8'b0_010_1_1_01;
        #5 encoded = 8'b0_011_0_0_11;
        #5 encoded = 8'b1_011_0_1_00;
        #5 encoded = 8'b0_100_1_0_11;
        #5 encoded = 8'b1_100_1_1_00;
        #5 encoded = 8'b1_101_0_0_10;
        #5 encoded = 8'b0_101_0_1_01;
        #5 encoded = 8'b1_110_0_0_01;
        #5 encoded = 8'b0_110_0_1_10;
        #5 encoded = 8'b0_111_1_0_00;
        #5 encoded = 8'b1_111_1_1_11;
        #5;     
        
        
        $display("\nSimulating a single bit flip on all input vectors, expecting SEC = 1:");
        #5 encoded = 8'b0_000_0_0_00 ^ 8'b10000000;
        #5 encoded = 8'b1_000_0_1_11 ^ 8'b00001000;
        #5 encoded = 8'b1_001_1_0_01 ^ 8'b00100000;
        #5 encoded = 8'b0_001_1_1_10 ^ 8'b00000100;
        #5 encoded = 8'b1_010_1_0_10 ^ 8'b00000001;
        #5 encoded = 8'b0_010_1_1_01 ^ 8'b00000100;
        #5 encoded = 8'b0_011_0_0_11 ^ 8'b00000001;
        #5 encoded = 8'b1_011_0_1_00 ^ 8'b00000001;
        #5 encoded = 8'b0_100_1_0_11 ^ 8'b00100000;
        #5 encoded = 8'b1_100_1_1_00 ^ 8'b00000010;
        #5 encoded = 8'b1_101_0_0_10 ^ 8'b10000000;
        #5 encoded = 8'b0_101_0_1_01 ^ 8'b00000100;
        #5 encoded = 8'b1_110_0_0_01 ^ 8'b00010000;
        #5 encoded = 8'b0_110_0_1_10 ^ 8'b00001000;
        #5 encoded = 8'b0_111_1_0_00 ^ 8'b00001000;
        #5 encoded = 8'b1_111_1_1_11 ^ 8'b00010000;
        #5;
        
        $display("\nSimulating a double bit flip on all input vectors, expecting DED = 1:");
        #5 encoded = 8'b0_000_0_0_00 ^ 8'b00100100;
        #5 encoded = 8'b1_000_0_1_11 ^ 8'b00011000;
        #5 encoded = 8'b1_001_1_0_01 ^ 8'b00100010;
        #5 encoded = 8'b0_001_1_1_10 ^ 8'b00000100;
        #5 encoded = 8'b1_010_1_0_10 ^ 8'b00100010;
        #5 encoded = 8'b0_010_1_1_01 ^ 8'b10000100;
        #5 encoded = 8'b0_011_0_0_11 ^ 8'b10000001;
        #5 encoded = 8'b1_011_0_1_00 ^ 8'b01000001;
        #5 encoded = 8'b0_100_1_0_11 ^ 8'b00100100;
        #5 encoded = 8'b1_100_1_1_00 ^ 8'b01000010;
        #5 encoded = 8'b1_101_0_0_10 ^ 8'b10001000;
        #5 encoded = 8'b0_101_0_1_01 ^ 8'b00000101;
        #5 encoded = 8'b1_110_0_0_01 ^ 8'b00010010;
        #5 encoded = 8'b0_110_0_1_10 ^ 8'b00011000;
        #5 encoded = 8'b0_111_1_0_00 ^ 8'b00101000;
        #5 encoded = 8'b1_111_1_1_11 ^ 8'b00010100;
        #5;
        
        $srandom($time);//random seed
        $display("\nSimulating random bit flips (MAX 2) on all input vectors: ");
        #5 randomTwoBits(randomMask);
        #5 encoded = 8'b0_000_0_0_00 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b1_000_0_1_11 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b1_001_1_0_01 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b0_001_1_1_10 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b1_010_1_0_10 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b0_010_1_1_01 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b0_011_0_0_11 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b1_011_0_1_00 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b0_100_1_0_11 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b1_100_1_1_00 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b1_101_0_0_10 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b0_101_0_1_01 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b1_110_0_0_01 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b0_110_0_1_10 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b0_111_1_0_00 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        randomTwoBits(randomMask);
        #5 encoded = 8'b1_111_1_1_11 ^ randomMask;
        $display($time," - Masking with random value:%d", randomMask);
        
        #5;
        
        #5 $finish;
    end
    
    task randomTwoBits(output integer random);
        integer  shift1, shift2;
        begin
            shift1 = $urandom %8; //random bit 0-7
            shift2 = $urandom %8; //random bit 0-7
            //each shift# represents the power of 2 desired for bit location to flip.
            random = ((1 << shift1) | (1 << shift2)); 
        end
    endtask
endmodule
