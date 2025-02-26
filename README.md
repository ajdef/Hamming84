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
 - Covers bits in the extended word where the LSB is 1 (1, 3, 5, 7)
 - Accounts for data bits 1, 2, and 4

**P2 (Middle Significant Bit)**
 - Covers bits in the extended word where second-to-LSB is 1 (2,3,6,7)
 - Accounts for data bits 1, 3, and 4

**P3 (Most Significant Bit)**
 - Covers bits in the extended word where the MSB is 1 (4,5,6,7)
 - Accounts for data bits 2, 3, and 4

Respective parity bits are calculated through the XOR of the 4 bits that make up the parity bit's definition, as described above.

This results in an encoded data word for SEC functionality.

## Bit order in the encoded word (SEC):
| Bit Index | 7 | 6 | 5 | 4 | 3 | 2 | 1 |
|-----------|---|---|---|---|---|---|---|
| Bit Definition | D4 | D3 | D2 | P3 | D1 | P2 | P1 |

## Enabling DED functionality:

In order to enable DEC, we need a parity value based on the entire encoded data word. Since previous implementations used even parity, a properly encoded word should have an even number of bits. Therefore, we can simply XOR every bit within the previously showcased word to wind up at the final encoded data word:

| Bit Index | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 |
|-----------|---|---|---|---|---|---|---|---|
| Bit Definition | P4 | D4 | D3 | D2 | P3 | D1 | P2 | P1 |

Where P4 is the new parity bit

## Decoding and checking for errors:

Decoding the data word is simply a process of masking exclusively the data bits from the encoded data word.

In order to ensure that this data word doesn't have any single/double bit errors, the parity bits are extracted and an even parity check is performed. This parity bit-exclusive word is referred to as the syndrome word/syndrome bits. If all 4 syndrome bits don't have even parity, it implies at least a single bit error. This single bit error can be corrected, as explained later. From here, the fourth syndrome bit is recalculated from the original word, and if the entire word does not hold even parity (after having already confirmed at least a single bit error), then it is sufficient to claim that a double bit error has occured, which is uncorrectable.

## Correcting single bit errors:
If a single bit error is recognized, the LSB of the syndrome word is concatenated and can be referred to as the error location. This is due to how the P1/P2/P3 bits, described above, account for specific bit fields within the original data word. Therefore, the concatenation describes where in the encoded word the transmission has had a bit flip. This error position can then be used as an index to locate and invert the bit that was flipped erroneously, correcting the error.






## To improve upon:
 - Parameterize Design for larger implementations (15,11)
 - Implement encoder and decoder between two seperate boards (Artix 7, Spartan 7) and interface as form of validation
 - Connect encoder/decoder to ADALM2000 (or similar analyzer) and automate/streamline validation
 - Explain Syndrome based detection methodology

