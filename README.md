# 4-bit ALU Design and Verification using SystemVerilog

## Overview

This project implements a 4-bit Arithmetic Logic Unit (ALU) and verifies its functionality using SystemVerilog.

The verification environment uses randomized stimulus, a driver, monitor, scoreboard, and functional coverage.

## Verification Components

- Transaction
- Generator
- Driver
- Monitor
- Scoreboard
- Functional Coverage
- Environment
- Test

## Project Structure

```text
rtl/
└── alu.sv

tb/
├── alu_transaction.sv
├── alu_generator.sv
├── alu_driver.sv
├── alu_monitor.sv
├── alu_scoreboard.sv
├── alu_coverage.sv
├── alu_environment.sv
├── alu_test.sv
└── tb_top.sv
