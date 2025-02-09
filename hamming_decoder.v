`timescale 1ns / 1ps
/*
*   8,4 Hamming Decoder 
*   Module by Alexander DeFalco
*   February 2025
*
* Similar to the encoder module, decoder module designed
* in order to check the parity of data bits as well as the
* entire encoded word to check for single and double errors
* with what is known as syndrome bits.
* syndrome bits 0:2 represent a single bit error, and syndrome 
* bit 3 represents a double bit error.
*/
module hamming_decoder (input [7:0] encoded,
                        output reg [3:0] data,
                        output reg SEC,
                        output reg DED     
);
    reg [3:0] syndrome; 
    reg [7:0] encoded_fixed;
    integer error_position;
   
    always @(*)begin
    //copy input to placeholder vector for later modification
    encoded_fixed = encoded;
    // P0:P2 checking
    syndrome[0] = encoded[2] ^ encoded[4] ^ encoded[6] ^ encoded[0]; //P0
    syndrome[1] = encoded[2] ^ encoded[5] ^ encoded[6] ^ encoded[1]; //P1
    syndrome[2] = encoded[4] ^ encoded[5] ^ encoded[6] ^ encoded[3]; //P2
    
    //concatenating parity bits to detect where error is located
    error_position = {syndrome[2], syndrome[1], syndrome[0]};
    
    // P3/extended parity bit checking
    syndrome[3] = encoded[7] ^ encoded[6] ^ encoded[5] ^ encoded[4] ^ encoded[3] ^ encoded[2] ^ encoded[1] ^ encoded[0];
    end
    
    //possible to combine with above always block, splitting keeps modular style
    always @(*) begin
    SEC = 0;    //initializing
    DED = 0;    //initializing
        if (syndrome != 4'b0000) begin
            if (syndrome[3] == 1'b0)begin   //extended parity 1 == 2 errors
                DED = 1;                    //flag 2 errors set
            end else begin
                SEC = 1;                    //other parity bits == 1 error
                encoded_fixed[error_position-1] = ~encoded_fixed[error_position-1];
            end
        end
        
        //concatenating data bits for final output
        data = {encoded_fixed[6], encoded_fixed[5], encoded_fixed[4], encoded_fixed[2]};
        
    end
endmodule