# SECDED

Verilog module and testbench designs for Extended Hamming(7,4) Code, often referred to as Single Error Correcting, Double Error Detecting (SECDED).

## Hamming Code?

Hamming code is a form of error correcting code (ECC) that is able to detect and correct single bit errors within the transmission of data through the addition of redundant/parity bits. An additional parity bit is able to be added to a hamming code implementation in order to add double bit error detection (not correction).

## How are these parity bits determined?
The number of parity bits utilized to support a given data word is provided by the following formula:

2^r >= d + r + 1

where:<br />
r = parity/redundant bits<br />
d = data bits<br />

Within this implementation, 4 data bits are used. Therefore, we can determine the number of parity bits needed:

2^r >= 4 + r + 1

Each data bit is mapped to a combination of parity bits, which are placed at the powers of 2 (2^2, 2^1, 2^0) within the encoded word. Even parity will be used, meaning any bit field with an odd number of bits will have a parity bit set to 1, causing the total number of bits (including the parity bit itself) to remain even.

This can be represented as a 3 entry wide truth table (r = 3):

Parity bit truth table:
|Bit #|P3|P2|P1|
|------|---|---|---|
| 0 | 0 | 0 | 0 |
| 1 | 0 | 0 | **1** |
| 2 | 0 | **1** | 0 |
| 3 | 0 | **1** | 1 |
| 4 | **1** | 0 | 0 |
| 5 | **1** | 0 | 1 |
| 6 | **1** | **1** | 0 |
| 7 | **1** | **1** | **1** |

### How parity bits cover data bits
**P1 (Least Significant Bit)**
 - 1
 - 2

**P2 (Middle Significant Bit)**
 - 1
 - 2

**P3 (Most Significant Bit)**
 - 1 
 - 2


## To improve upon:
 - Parameterize Design for larger implementations (15,11)
 - Implement encoder and decoder between two seperate boards (Artix 7, Spartan 7) and interface as form of validation
 - Connect encoder/decoder to ADALM2000 (or similar analyzer) and automate/streamline validation

