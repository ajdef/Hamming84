`timescale 1ns / 1ps
/*
*   8,4 Hamming Encoder 
*   Module by Alexander DeFalco
*   February 2025
*
* Module designed to function as a SECDED/Hamming (8,4) Encoder.
* Behaves the same as a Hamming (7,4) encoder with extended
* parity bit. (7,4) behavior enables SEC functionality, extended 
* parity bit enables DED functionality.
*
* input will be 4 data bits, encoding will involve the addition of
* 3 parity bits for the actual integrity of each respective bit field,
* as well as extended parity bit for the integrity of the entire
* encoding, allowing for a second error to be detected.
* 
* Individual field parity bits (to make up 7,4 behavior) are derived 
* from powers of 2: 2^0, 2^1, 2^2. Data bits are placed around these.
* 
* parity bits will be represented as a single vector, 4 bits wide, in
* the form of {p3,p2,p1,p0}, with p4 representing the DED parity bit
* and p2,p1,p0 representing field parity bits.
*
* the encoded data will be in the following format:
* p3 d3 d2 d1 p2 d0 p1 p0
* msb --------------> lsb
* extended parity bit will be placed as the MSB
*
* 0 0 0 NA 
* 0 0 1 P0
* 0 1 0 P1
* 0 1 1 D1
* 1 0 0 P2
* 1 0 1 D2
* 1 1 0 D3
* 1 1 1 D4
*
*/

module hamming_encoder( input [3:0] data,
                        output reg [7:0] encoded
    );
 
    reg [3:0] parity; //reg to allow for always block
    
    always @(*)begin
        //Standard hamming parity bit derivations:
        parity[0] = data[0] ^ data[1] ^ data[3]; 
        parity[1] = data[0] ^ data[2] ^ data[3];
        parity[2] = data[1] ^ data[2] ^ data[3];
        
        //Extended hamming parity bit derivation:
        parity[3] = data[0] ^ data[1] ^ data[2] ^ data[3] ^ parity[0] ^ parity[1] ^ parity[2];
        
        //Concatenation to provide output: {Extended Parity, D3, D2, D1, P2, D0, P1, P0}
        encoded = {parity[3], data[3], data[2], data[1], parity[2], data[0], parity[1], parity[0]};
       
    end
    
endmodule