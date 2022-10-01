# MIPS-CPU-Project
:star: This repository is the CPU project of Instruction Architecture and Compiler course in 2nd Year Imperial College London EIE department.

## Overview
The repository contains a pipelined and non-pipelined version of a 5-stages MIPS-compatible CPU. The CPU is programmed using Verilog. Moreover, a testbench with a reference CPU coded using C++ is included. The testbench consists of automatically generated testcases for each required instruciton and several general testcases containing a mixture of different instructions.

## Running Guidelines
Use <code> test/test_mips_cpu_bus.sh rtl </code> to run the pipelined version of the CPU.

Use <code> test/test_mips_cpu_bus_pipeline.sh rtl </code> to run the pipelined version of the CPU.

Use <code> test/test_mips_cpu_bus.sh rtl INSTRUCTIONNAME </code> or <code> test/test_mips_cpu_bus_pipeline.sh rtl INSTRUCTIONNAME </code> to run a specific instruction set folder. INSTRUCTIONNAME is the name of the instruction type that you want to run. For example, if you want to test the non-pipelined CPU with the instuction *addiu*, run code  <code> test/test_mips_cpu_bus.sh rtl addiu </code>.
