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
        OpCode("LD BC,nn",16,{(cpu: GameBoyCPU) in LD_rr_nn(cpu, &cpu.registers.B, &cpu.registers.C)}),
        OpCode("LD (BC),A",0,nil),
        OpCode("INC BC",0,nil),
        OpCode("INC B",0,nil),
        OpCode("DEC B",0,{(cpu: GameBoyCPU) in DEC_r(cpu, &cpu.registers.B)}),
        OpCode("LD B,n",0,{(cpu: GameBoyCPU) in LD_r_n(cpu, &cpu.registers.B)}),
        OpCode("RLC A",0,nil),
        OpCode("LD (nn),SP",0,nil),
        OpCode("ADD HL,BC",0,nil),
        OpCode("LD A,(BC)",0,nil),
        OpCode("DEC BC",0,{(cpu: GameBoyCPU) in DEC_rr(cpu, &cpu.registers.B, &cpu.registers.C)}),
        OpCode("INC C",0,{(cpu: GameBoyCPU) in DEC_r(cpu, &cpu.registers.C)}),
        OpCode("DEC C",0,{(cpu: GameBoyCPU) in DEC_r(cpu, &cpu.registers.C)}),
        OpCode("LD C,n",0,{(cpu: GameBoyCPU) in LD_r_n(cpu, &cpu.registers.C)}),
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
        OpCode("LD HL,nn",0,{(cpu: GameBoyCPU) in LD_rr_nn(cpu, &cpu.registers.H, &cpu.registers.L)}),
        OpCode("LDI (HL),A",0,nil),
        OpCode("INC HL",0,nil),
        OpCode("INC H",0,nil),
        OpCode("DEC H",0,nil),
        OpCode("LD H,n",0,nil),
        OpCode("DAA",0,nil),
        OpCode("JR Z,n",0,nil),
        OpCode("ADD HL,HL",0,nil),
        OpCode("LDI A,(HL)",0,LDI_A_aHL),
        OpCode("DEC HL",0,nil),
        OpCode("INC L",0,nil),
        OpCode("DEC L",0,nil),
        OpCode("LD L,n",0,nil),
        OpCode("CPL",0,CPL),
        //0x3n
        OpCode("JR NC,n",0,nil),
        OpCode("LD SP,nn",0,LD_SP_nn),
        OpCode("LDD (HL),A",0,LDD_aHL_A),
        OpCode("INC SP",0,nil),
        OpCode("INC (HL)",0,nil),
        OpCode("DEC (HL)",0,nil),
        OpCode("LD (HL),n",0,LD_aHL_n),
        OpCode("SCF",0,nil),
        OpCode("JR C,n",0,nil),
        OpCode("ADD HL,SP",0,nil),
        OpCode("LDD A,(HL)",0,nil),
        OpCode("DEC SP",0,nil),
        OpCode("INC A",0,nil),
        OpCode("DEC A",0,nil),
        OpCode("LD A,n",0,{(cpu: GameBoyCPU) in LD_r_n(cpu, &cpu.registers.A)}),
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
        OpCode("LD A,B",0,{(cpu: GameBoyCPU) in LD_r_r(cpu, &cpu.registers.A, cpu.registers.B)}),
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
        OpCode("XOR A",0,{(cpu: GameBoyCPU) in XOR_r(cpu, &cpu.registers.A)}),
        //0xBn
        OpCode("OR B",0,nil),
        OpCode("OR C",0,{(cpu: GameBoyCPU) in OR_r(cpu, &cpu.registers.C)}),
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
        OpCode("RET",0,RET),
        OpCode("JP Z,nn",0,nil),
        OpCode("Two byte instruction set: Ext ops",0,EXT_OPCODE),
        OpCode("CALL Z,nn",0,nil),
        OpCode("CALL nn",0,CALL_nn),
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
        OpCode("LDH (n),A",0,LDH_an_A),
        OpCode("POP HL",0,nil),
        OpCode("LDH (C),A",0,LDH_aC_A),
        OpCode("XX",0,nil),
        OpCode("XX",0,nil),
        OpCode("PUSH HL",0,nil),
        OpCode("AND n",0,nil),
        OpCode("RST 20",0,nil),
        OpCode("ADD SP,d",0,nil),
        OpCode("JP (HL)",0,JP_aHL),
        OpCode("LD (nn),A",0,LD_ann_A),
        OpCode("XX",0,nil),
        OpCode("XX",0,nil),
        OpCode("XX",0,nil),
        OpCode("XOR n",0,nil),
        OpCode("RST 28",0,nil),
        //0xFn
        OpCode("LDH A,(n)",0,LDH_A_an),
        OpCode("POP AF",0,nil),
        OpCode("XX",0,nil),
        OpCode("DI",0,DI),
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
        OpCode("CP n",0,CP_n),
        OpCode("RST 38",0,nil)]
    return table
}

/*
F - flags register:
0x80 - Z - last result was zero
0x40 - N - last operation did subtraction
0x20 - H - half-carry when during operation a bit is carried from lower nimble to higher or vice versa
0x10 - CY - carry when operation carries over 255 or under 0
*/

let F_ZERO: UInt8 = 0x80
let F_NEGATIVE: UInt8 = 0x40
let F_HALF_CARRY: UInt8 = 0x20
let F_CARRY: UInt8 = 0x10

//instructions
func NOP(cpu: GameBoyCPU) {
    cpu.registers.PC++
    cpu.updateClock(1)
}
func DI(cpu: GameBoyCPU) { //disable interrupts
    //TODO implement
    cpu.registers.PC++
    cpu.updateClock(1)
}

// loading
// load from register to register
func LD_r_r(cpu: GameBoyCPU, inout reg1: UInt8, reg2: UInt8) {
    reg1=reg2
    cpu.registers.PC++
    cpu.updateClock(1)
}
// load from imediate to register
func LD_r_n(cpu: GameBoyCPU, inout reg: UInt8) {
    reg = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.registers.PC+=2
    cpu.updateClock(2)
}
// load from address in HL to register
func LD_r_aHL(cpu: GameBoyCPU, inout reg: UInt8) {
    reg = cpu.memory.read(address: cpu.registers.getHL())
    cpu.registers.PC++
    cpu.updateClock(2)
}
// load from register to address in HL
func LD_aHL_r(cpu: GameBoyCPU, reg: UInt8) {
    var addr = cpu.registers.getHL()
    cpu.memory.write(address: addr, value: reg)
    cpu.registers.PC++
    cpu.updateClock(2)
}
// load from imediate to address in HL
func LD_aHL_n(cpu: GameBoyCPU) {
    let addr = cpu.registers.getHL()
    let value = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.memory.write(address: addr, value: value)
    cpu.registers.PC+=2
    cpu.updateClock(3)
}
// load from address in register pair to A
func LD_A_arr(cpu: GameBoyCPU, regH: UInt8, regL: UInt8) {
    var addr = cpu.registers.get16(regH,regL)
    cpu.registers.A = cpu.memory.read(address: addr)
    cpu.registers.PC++
    cpu.updateClock(2)
}
// load from address in 16bit imediate to A
func LD_A_ann(cpu: GameBoyCPU) {
    var addr = cpu.memory.read16(address: cpu.registers.PC+1)
    cpu.registers.A = cpu.memory.read(address: addr)
    cpu.registers.PC+=3
    cpu.updateClock(4)
}


func LD_rr_nn(cpu: GameBoyCPU, inout regH: UInt8, inout regL: UInt8) {
    cpu.registers.set16(&regH, &regL, value: cpu.memory.read16(address: cpu.registers.PC+1))
    cpu.registers.PC+=3
    cpu.updateClock(3)
}
func LD_SP_nn(cpu: GameBoyCPU) {
    cpu.registers.SP = cpu.memory.read16(address: cpu.registers.PC+1)
    cpu.registers.PC+=3
    cpu.updateClock(3)
}



func LDD_aHL_A(cpu: GameBoyCPU) {
    var addr = cpu.registers.getHL()
    cpu.memory.write(address: addr, value: cpu.registers.A)
    --addr
    cpu.registers.setHL(addr)
    cpu.registers.PC++
    cpu.updateClock(2)
}
func LDI_A_aHL(cpu: GameBoyCPU) {
    var addr = cpu.registers.getHL()
    cpu.registers.A = cpu.memory.read(address: addr)
    ++addr
    cpu.registers.setHL(addr)
    //cpu.registers.H = UInt8(addr >> 8)
    //cpu.registers.L = UInt8(addr & 0xFF)
    cpu.registers.PC++
    cpu.updateClock(2)
}

func LD_ann_A(cpu: GameBoyCPU) {
    let addr = cpu.memory.read16(address: cpu.registers.PC+1)
    cpu.memory.write(address: addr, value: cpu.registers.A)
    cpu.registers.PC+=3
    cpu.updateClock(4)
}
func LDH_an_A(cpu: GameBoyCPU) {
    let addr = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.memory.write(address: UInt16(addr) + 0xFF00, value: cpu.registers.A)
    cpu.registers.PC+=2
    cpu.updateClock(3)
}
func LDH_A_an(cpu: GameBoyCPU) {
    let addr = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.registers.A = cpu.memory.read(address: UInt16(addr) + 0xFF00)
    cpu.registers.PC+=2
    cpu.updateClock(3)
}
func LDH_aC_A(cpu: GameBoyCPU) {
    cpu.memory.write(address: UInt16(cpu.registers.C) + 0xFF00, value: cpu.registers.A)
    cpu.registers.PC++
    cpu.updateClock(3)
}

// jumps
func JP_nn(cpu: GameBoyCPU) {
    cpu.registers.PC = cpu.memory.read16(address: cpu.registers.PC+1)
    cpu.updateClock(4)
}
func JP_aHL(cpu: GameBoyCPU) {
    cpu.registers.PC = cpu.registers.getHL()
    cpu.updateClock(1)
}

func JR_NZ_n(cpu: GameBoyCPU) {
    if(cpu.registers.F & F_ZERO == 0) {
        var num = cpu.memory.read(address: cpu.registers.PC+1)
        //var jump = Int(num)
        if(num & 0x80 > 0) {
            cpu.registers.PC = cpu.registers.PC &- UInt16(num^0xFF)
        } else {
            cpu.registers.PC = cpu.registers.PC &+ UInt16(num)
        }
        cpu.registers.PC++
        cpu.updateClock(3)
    } else {
        cpu.registers.PC += 2
        cpu.updateClock(2)
    }
}
func CALL_nn(cpu: GameBoyCPU) {
    let jump = cpu.memory.read16(address: cpu.registers.PC+1)
    cpu.memory.write16(address: cpu.registers.SP-2, value: cpu.registers.PC+1)
    cpu.registers.PC = jump
    cpu.registers.SP -= 2;
    cpu.updateClock(6)
}
func RET(cpu: GameBoyCPU) {
    cpu.registers.PC = cpu.memory.read16(address: cpu.registers.SP)
    cpu.registers.SP += 2
    cpu.updateClock(4)
}


// arithmetic
func DEC_r(cpu: GameBoyCPU, inout reg: UInt8) {
    //flags
    cpu.registers.F = F_NEGATIVE
    if reg == 0x01 { cpu.registers.F |= F_ZERO }
    if reg & 0x0F == 0 { cpu.registers.F |= F_HALF_CARRY }
    reg = reg &- 1
    cpu.registers.PC++
    cpu.updateClock(1)
}

func DEC_rr(cpu: GameBoyCPU, inout regH: UInt8, inout regL: UInt8) {
    var value = cpu.registers.get16(regH, regL)
    value = value &- 1
    cpu.registers.setBC(value)
    cpu.registers.PC++
    cpu.updateClock(2)
}
func INC_r(cpu: GameBoyCPU, inout reg: UInt8) {
    //flags
    cpu.registers.F = 0
    if reg == 0xFF { cpu.registers.F |= F_ZERO }
    if reg & 0x0F == 0x0F { cpu.registers.F |= F_HALF_CARRY }
    reg = reg &+ 1
    cpu.registers.PC++
    cpu.updateClock(1)
}
func CPL(cpu: GameBoyCPU) {
    cpu.registers.A = 0xFF - cpu.registers.A
    cpu.registers.F = F_HALF_CARRY | F_NEGATIVE
    cpu.registers.PC++
    cpu.updateClock(1)
}

// logical
func CP_n(cpu: GameBoyCPU) {
    let value = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.registers.F = F_NEGATIVE
    if cpu.registers.A == value { cpu.registers.F |= F_ZERO }
    if cpu.registers.A & 0x0F < value & 0x0F { cpu.registers.F |= F_HALF_CARRY }
    if cpu.registers.A < value { cpu.registers.F |= F_CARRY }
    
    cpu.registers.PC+=2
    cpu.updateClock(1)
}
func OR_r(cpu: GameBoyCPU, inout reg: UInt8) {
    cpu.registers.A |= reg
    cpu.registers.F = cpu.registers.A == 0 ? F_ZERO : 0
    cpu.registers.PC++
    cpu.updateClock(1)
}
func XOR_r(cpu: GameBoyCPU, inout reg: UInt8) {
    cpu.registers.A ^= reg
    cpu.registers.F = cpu.registers.A == 0 ? F_ZERO : 0
    cpu.registers.PC++
    cpu.updateClock(1)
}

// 16 bit opcodes
func EXT_OPCODE(cpu: GameBoyCPU) {
    let instr = cpu.memory.read(address: cpu.registers.PC+1)
    println("dupa")
    exit(-1)
}
