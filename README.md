# 8-bit ALU Design and Verification using SystemVerilog

## Overview

This project implements an 8-bit Arithmetic Logic Unit (ALU) and verifies its functionality using SystemVerilog.

The ALU performs arithmetic, logical, and shift operations based on a 3-bit opcode.

The verification environment uses randomized stimulus, a driver, monitor, scoreboard, assertions, and functional coverage to verify the DUT.

## ALU Operations

| Opcode | Operation |
|--------|-----------|
| 000 | Addition |
| 001 | Subtraction |
| 010 | AND |
| 011 | OR |
| 100 | XOR |
| 101 | NOT |
| 110 | Left Shift |
| 111 | Right Shift |

## DUT Inputs and Outputs

### Inputs

- `A` – 8-bit input
- `B` – 8-bit input
- `opcode` – 3-bit operation select

### Outputs

- `Result` – 8-bit ALU result
- `Carry` – Carry output for addition
- `Zero` – Indicates whether the result is zero

## Verification Environment

The SystemVerilog testbench is organized into the following components:

- **Transaction** – Stores randomized input stimulus and DUT outputs
- **Generator** – Generates randomized transactions
- **Driver** – Drives transactions to the DUT through the virtual interface
- **Monitor** – Captures DUT inputs and outputs
- **Scoreboard** – Calculates expected results and compares them with actual DUT outputs
- **Functional Coverage** – Measures coverage of opcodes and important input values
- **Environment** – Instantiates and connects the verification components
- **Test** – Creates the interface, DUT, and verification environment and starts the simulation

## Verification Flow

```text
        Generator
            |
            v
       Transaction
            |
            v
         Driver
            |
            v
           DUT
        (8-bit ALU)
            |
            v
         Monitor
            |
            v
       Scoreboard
            |
            v
   Expected vs Actual
