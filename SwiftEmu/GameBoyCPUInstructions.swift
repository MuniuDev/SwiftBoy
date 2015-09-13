//
//  GameBoyCPUOpcodes.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 13.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Foundation

struct OpCode {
    var name: String
    var operandSize: Int
    var instruction: ((cpu: GameBoyCPU)->Void)?
    init(_ name: String, _ size: Int, _ instr: ((cpu: GameBoyCPU)->Void)? = nil) {
        self.name = name
        operandSize = size
        instruction = instr
    }
    
}

func generateOpCodeTable() -> [OpCode] {
    var table = [
        //0x0n
        OpCode("NOP",0,NOP),
        OpCode("LD BC,nn",16,nil),
        OpCode("LD (BC),A",0,nil),
        OpCode("INC BC",0,nil),
        OpCode("INC B",0,nil),
        OpCode("DEC B",0,DEC_B),
        OpCode("LD B,n",0,LD_B_n),
        OpCode("RLC A",0,nil),
        OpCode("LD (nn),SP",0,nil),
        OpCode("ADD HL,BC",0,nil),
        OpCode("LD A,(BC)",0,nil),
        OpCode("DEC BC",0,nil),
        OpCode("INC C",0,nil),
        OpCode("DEC C",0,DEC_C),
        OpCode("LD C,n",0,LD_C_n),
        OpCode("RRC A",0,nil),
        //0x1n
        OpCode("STOP",0,nil),
        OpCode("LD DE,nn",0,nil),
        OpCode("LD (DE),A",0,nil),
        OpCode("INC DE",0,nil),
        OpCode("INC D",0,nil),
        OpCode("DEC D",0,nil),
        OpCode("LD D,n",0,nil),
        OpCode("RL A",0,nil),
        OpCode("JR n",0,nil),
        OpCode("ADD HL,DE",0,nil),
        OpCode("LD A,(DE)",0,nil),
        OpCode("DEC DE",0,nil),
        OpCode("INC E",0,nil),
        OpCode("DEC E",0,nil),
        OpCode("LD E,n",0,nil),
        OpCode("RR A",0,nil),
        //0x2n
        OpCode("JR NZ,n",0,JR_NZ_n),
        OpCode("LD HL,nn",0,LD_HL_nn),
        OpCode("LDI (HL),A",0,nil),
        OpCode("INC HL",0,nil),
        OpCode("INC H",0,nil),
        OpCode("DEC H",0,nil),
        OpCode("LD H,n",0,nil),
        OpCode("DAA",0,nil),
        OpCode("JR Z,n",0,nil),
        OpCode("ADD HL,HL",0,nil),
        OpCode("LDI A,(HL)",0,nil),
        OpCode("DEC HL",0,nil),
        OpCode("INC L",0,nil),
        OpCode("DEC L",0,nil),
        OpCode("LD L,n",0,nil),
        OpCode("CPL",0,nil),
        //0x3n
        OpCode("JR NC,n",0,nil),
        OpCode("LD SP,nn",0,LD_SP_nn),
        OpCode("LDD (HL),A",0,LDD_aHL_A),
        OpCode("INC SP",0,nil),
        OpCode("INC (HL)",0,nil),
        OpCode("DEC (HL)",0,nil),
        OpCode("LD (HL),n",0,nil),
        OpCode("SCF",0,nil),
        OpCode("JR C,n",0,nil),
        OpCode("ADD HL,SP",0,nil),
        OpCode("LDD A,(HL)",0,nil),
        OpCode("DEC SP",0,nil),
        OpCode("INC A",0,nil),
        OpCode("DEC A",0,nil),
        OpCode("LD A,n",0,nil),
        OpCode("CCF",0,nil),
        //0x4n
        OpCode("LD B,B",0,nil),
        OpCode("LD B,C",0,nil),
        OpCode("LD B,D",0,nil),
        OpCode("LD B,E",0,nil),
        OpCode("LD B,H",0,nil),
        OpCode("LD B,L",0,nil),
        OpCode("LD B,(HL)",0,nil),
        OpCode("LD B,A",0,nil),
        OpCode("LD C,B",0,nil),
        OpCode("LD C,C",0,nil),
        OpCode("LD C,D",0,nil),
        OpCode("LD C,E",0,nil),
        OpCode("LD C,H",0,nil),
        OpCode("LD C,L",0,nil),
        OpCode("LD C,(HL)",0,nil),
        OpCode("LD C,A",0,nil),
        //0x5n
        OpCode("LD D,B",0,nil),
        OpCode("LD D,C",0,nil),
        OpCode("LD D,D",0,nil),
        OpCode("LD D,E",0,nil),
        OpCode("LD D,H",0,nil),
        OpCode("LD D,L",0,nil),
        OpCode("LD D,(HL)",0,nil),
        OpCode("LD D,A",0,nil),
        OpCode("LD E,B",0,nil),
        OpCode("LD E,C",0,nil),
        OpCode("LD E,D",0,nil),
        OpCode("LD E,E",0,nil),
        OpCode("LD E,H",0,nil),
        OpCode("LD E,L",0,nil),
        OpCode("LD E,(HL)",0,nil),
        OpCode("LD E,A",0,nil),
        //0x6n
        OpCode("LD H,B",0,nil),
        OpCode("LD H,C",0,nil),
        OpCode("LD H,D",0,nil),
        OpCode("LD H,E",0,nil),
        OpCode("LD H,H",0,nil),
        OpCode("LD H,L",0,nil),
        OpCode("LD H,(HL)",0,nil),
        OpCode("LD H,A",0,nil),
        OpCode("LD L,B",0,nil),
        OpCode("LD L,C",0,nil),
        OpCode("LD L,D",0,nil),
        OpCode("LD L,E",0,nil),
        OpCode("LD L,H",0,nil),
        OpCode("LD L,L",0,nil),
        OpCode("LD L,(HL)",0,nil),
        OpCode("LD L,A",0,nil),
        //0x7n
        OpCode("LD (HL),B",0,nil),
        OpCode("LD (HL),C",0,nil),
        OpCode("LD (HL),D",0,nil),
        OpCode("LD (HL),E",0,nil),
        OpCode("LD (HL),H",0,nil),
        OpCode("LD (HL),L",0,nil),
        OpCode("HALT",0,nil),
        OpCode("LD (HL),A",0,nil),
        OpCode("LD A,B",0,nil),
        OpCode("LD A,C",0,nil),
        OpCode("LD A,D",0,nil),
        OpCode("LD A,E",0,nil),
        OpCode("LD A,H",0,nil),
        OpCode("LD A,L",0,nil),
        OpCode("LD A,(HL)",0,nil),
        OpCode("LD A,A",0,nil),
        //0x8n
        OpCode("ADD A,B",0,nil),
        OpCode("ADD A,C",0,nil),
        OpCode("ADD A,D",0,nil),
        OpCode("ADD A,E",0,nil),
        OpCode("ADD A,H",0,nil),
        OpCode("ADD A,L",0,nil),
        OpCode("ADD A,(HL)",0,nil),
        OpCode("ADD A,A",0,nil),
        OpCode("ADC A,B",0,nil),
        OpCode("ADC A,C",0,nil),
        OpCode("ADC A,D",0,nil),
        OpCode("ADC A,E",0,nil),
        OpCode("ADC A,H",0,nil),
        OpCode("ADC A,L",0,nil),
        OpCode("ADC A,(HL)",0,nil),
        OpCode("ADC A,A",0,nil),
        //0x9n
        OpCode("SUB A,B",0,nil),
        OpCode("SUB A,C",0,nil),
        OpCode("SUB A,D",0,nil),
        OpCode("SUB A,E",0,nil),
        OpCode("SUB A,H",0,nil),
        OpCode("SUB A,L",0,nil),
        OpCode("SUB A,(HL)",0,nil),
        OpCode("SUB A,A",0,nil),
        OpCode("SBC A,B",0,nil),
        OpCode("SBC A,C",0,nil),
        OpCode("SBC A,D",0,nil),
        OpCode("SBC A,E",0,nil),
        OpCode("SBC A,H",0,nil),
        OpCode("SBC A,L",0,nil),
        OpCode("SBC A,(HL)",0,nil),
        OpCode("SBC A,A",0,nil),
        //0xAn
        OpCode("AND B",0,nil),
        OpCode("AND C",0,nil),
        OpCode("AND D",0,nil),
        OpCode("AND E",0,nil),
        OpCode("AND H",0,nil),
        OpCode("AND L",0,nil),
        OpCode("AND (HL)",0,nil),
        OpCode("AND A",0,nil),
        OpCode("XOR B",0,nil),
        OpCode("XOR C",0,nil),
        OpCode("XOR D",0,nil),
        OpCode("XOR E",0,nil),
        OpCode("XOR H",0,nil),
        OpCode("XOR L",0,nil),
        OpCode("XOR (HL)",0,nil),
        OpCode("XOR A",0,XOR_A),
        //0xBn
        OpCode("OR B",0,nil),
        OpCode("OR C",0,nil),
        OpCode("OR D",0,nil),
        OpCode("OR E",0,nil),
        OpCode("OR H",0,nil),
        OpCode("OR L",0,nil),
        OpCode("OR (HL)",0,nil),
        OpCode("OR A",0,nil),
        OpCode("CP B",0,nil),
        OpCode("CP C",0,nil),
        OpCode("CP D",0,nil),
        OpCode("CP E",0,nil),
        OpCode("CP H",0,nil),
        OpCode("CP L",0,nil),
        OpCode("CP (HL)",0,nil),
        OpCode("CP A",0,nil),
        //0xCn
        OpCode("RET NZ",0,nil),
        OpCode("POP BC",0,nil),
        OpCode("JP NZ,nn",0,nil),
        OpCode("JP nn",0,JP_nn),
        OpCode("CALL NZ,nn",0,nil),
        OpCode("PUSH BC",0,nil),
        OpCode("ADD A,n",0,nil),
        OpCode("RST 0",0,nil),
        OpCode("RET Z",0,nil),
        OpCode("RET",0,nil),
        OpCode("JP Z,nn",0,nil),
        OpCode("Two byte instruction set: Ext ops",0,nil),
        OpCode("CALL Z,nn",0,nil),
        OpCode("CALL nn",0,nil),
        OpCode("ADC A,n",0,nil),
        OpCode("RST 8",0,nil),
        //0xDn
        OpCode("RET NC",0,nil),
        OpCode("POP DE",0,nil),
        OpCode("JP NC,nn",0,nil),
        OpCode("XX",0,nil),
        OpCode("CALL NC,nn",0,nil),
        OpCode("PUSH DE",0,nil),
        OpCode("SUB A,n",0,nil),
        OpCode("RST 10",0,nil),
        OpCode("RET C",0,nil),
        OpCode("RETI",0,nil),
        OpCode("JP C,nn",0,nil),
        OpCode("XX",0,nil),
        OpCode("CALL C,nn",0,nil),
        OpCode("XX",0,nil),
        OpCode("SBC A,n",0,nil),
        OpCode("RST 18",0,nil),
        //0xEn
        OpCode("LDH (n),A",0,nil),
        OpCode("POP HL",0,nil),
        OpCode("LDH (C),A",0,nil),
        OpCode("XX",0,nil),
        OpCode("XX",0,nil),
        OpCode("PUSH HL",0,nil),
        OpCode("AND n",0,nil),
        OpCode("RST 20",0,nil),
        OpCode("ADD SP,d",0,nil),
        OpCode("JP (HL)",0,nil),
        OpCode("LD (nn),A",0,nil),
        OpCode("XX",0,nil),
        OpCode("XX",0,nil),
        OpCode("XX",0,nil),
        OpCode("XOR n",0,nil),
        OpCode("RST 28",0,nil),
        //0xFn
        OpCode("LDH A,(n)",0,nil),
        OpCode("POP AF",0,nil),
        OpCode("XX",0,nil),
        OpCode("DI",0,nil),
        OpCode("XX",0,nil),
        OpCode("PUSH AF",0,nil),
        OpCode("OR n",0,nil),
        OpCode("RST 30",0,nil),
        OpCode("LDHL SP,d",0,nil),
        OpCode("LD SP,HL",0,nil),
        OpCode("LD A,(NN)",0,nil),
        OpCode("EI",0,nil),
        OpCode("XX",0,nil),
        OpCode("XX",0,nil),
        OpCode("CP n",0,nil),
        OpCode("RST 38",0,nil)]
    return table
}

/*
F - flags register:
0x80 - Z - last result was zero
0x40 - N - last operation did subtraction
0x20 - H - half-carry when operation carried a nuber past 15 (e.g. 13 + 5 = 18)
0x10 - CY - carry when operation carries over 255 or under 0
*/

let F_ZERO: UInt8 = 0x80
let F_NEGATIVE: UInt8 = 0x40
let F_HALF_CARRY: UInt8 = 0x20
let F_CARRY: UInt8 = 0x10

//instructions
func NOP(cpu: GameBoyCPU) {
    cpu.registers.PC++
    cpu.clock++
}

// loading
func LD_B_n(cpu: GameBoyCPU) {
    cpu.registers.B = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.registers.PC+=2
    cpu.clock+=2
}
func LD_C_n(cpu: GameBoyCPU) {
    cpu.registers.C = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.registers.PC+=2
    cpu.clock+=2
}
func LD_SP_nn(cpu: GameBoyCPU) {
    cpu.registers.SP = cpu.memory.read16(address: cpu.registers.PC+1)
    cpu.registers.PC+=3
    cpu.clock+=3
}
func LD_HL_nn(cpu: GameBoyCPU) {
    cpu.registers.H = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.registers.L = cpu.memory.read(address: cpu.registers.PC+2)
    cpu.registers.PC+=3
    cpu.clock+=3
}
func LDD_aHL_A(cpu: GameBoyCPU) {
    let addr = UInt16(cpu.registers.H) << 8 + UInt16(cpu.registers.L)
    cpu.memory.write(address: addr, value: cpu.registers.A)
    cpu.registers.PC++
    cpu.clock+=2
}

// jumps
func JP_nn(cpu: GameBoyCPU) {
    cpu.registers.PC = cpu.memory.read16(address: cpu.registers.PC+1)
    cpu.clock+=4
}
func JR_NZ_n(cpu: GameBoyCPU) {
    if(cpu.registers.F & F_ZERO > 0) {
        var jump = Int(cpu.memory.read(address: cpu.registers.PC+1)) - 127
        if Int(cpu.registers.PC) + jump >= 0 {
            cpu.registers.PC = UInt16(Int(cpu.registers.PC) + jump)
        } else if Int(cpu.registers.PC) + jump < 65536 {
            cpu.registers.PC = UInt16(Int(cpu.registers.PC) + jump - 65536)
        } else {
            cpu.registers.PC = UInt16(Int(cpu.registers.PC) + jump + 65536)
        }
        cpu.clock += 3
    } else {
        cpu.registers.PC += 2
        cpu.clock += 2
    }
}


// arithmetic
func DEC_B(cpu: GameBoyCPU) {
    if cpu.registers.B == 0 {
        cpu.registers.B = 255
    } else {
        --cpu.registers.B
    }
    //flags
    cpu.registers.F = F_NEGATIVE
    if cpu.registers.B == 0x00 { cpu.registers.F |= F_ZERO }
    if cpu.registers.B == 0x0F { cpu.registers.F |= F_HALF_CARRY }
    cpu.registers.PC++
    cpu.clock++
}
func DEC_C(cpu: GameBoyCPU) {
    if cpu.registers.C == 0 {
        cpu.registers.C = 255
    } else {
        --cpu.registers.C
    }
    //flags
    cpu.registers.F = F_NEGATIVE
    if cpu.registers.C == 0x00 { cpu.registers.F |= F_ZERO }
    if cpu.registers.C == 0x0F { cpu.registers.F |= F_HALF_CARRY }
    cpu.registers.PC++
    cpu.clock++
}

// logical
func XOR_A(cpu: GameBoyCPU) {
    cpu.registers.A ^= cpu.registers.A
    cpu.registers.PC++
    cpu.clock++
}
