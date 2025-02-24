# SECDED

Verilog module and testbench designs for Extended Hamming(7,4) Code, often referred to as Single Error Correcting, Double Error Detecting (SECDED).

## Hamming Code?

Hamming code is a form of error correcting code (ECC) that is able to detect and correct single bit errors within the transmission of data through the addition of parity bits. An additional parity bit is able to be added to a hamming code implementation in order to add double bit error detection (not correction).

### How are these parity bits determined?

## To improve upon:
 - Parameterize Design for larger implementations (15,11)
 - Implement encoder and decoder between two seperate boards (Artix 7, Spartan 7) and interface as form of validation
 - Connect encoder/decoder to ADALM2000 (or similar analyzer) and automate/streamline validation

