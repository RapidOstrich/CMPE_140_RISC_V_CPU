Top level module is 'cpu.v'.

CPU Block Components:
  Decoder
  ALU Multiplexer (Sign Extender)
  ALU
  Register File
  Pipeline Registers

4 Stages: Fetch --> Decode --> Execute --> Write Back

Data flow:
  1. 32-bit instruction is passed to CPU; Instruction is stored in pipeline register.
  2. 32-bit instruction is passed from the pipeline instruction-register to the decoder.
  3. The decoder identifies the 7-bit opcode and retrieves the necessary register values from the register file. These values are stored into another pipeline register.
  4. The pipeline decoder-register values are passed to the ALU. The resulting value from the ALU is stored in another pipeline register.
  5. The pipeline ALU register values are written to the register file.
