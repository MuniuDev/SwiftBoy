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
    var instruction: ((cpu: GameBoyCPU)->Void)?
    init(_ name: String, _ instr: ((cpu: GameBoyCPU)->Void)? = nil) {
        self.name = name
        instruction = instr
    }
    
}

func generateOpCodeTable() -> [OpCode] {
    var table = [
        //0x0n
        OpCode("NOP",NOP),
        OpCode("LD BC,nn",{(cpu: GameBoyCPU) in LD_rr_nn(cpu, &cpu.registers.B, &cpu.registers.C)}),
        OpCode("LD (BC),A",nil),
        OpCode("INC BC",nil),
        OpCode("INC B",nil),
        OpCode("DEC B",{(cpu: GameBoyCPU) in DEC_r(cpu, &cpu.registers.B)}),
        OpCode("LD B,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, &cpu.registers.B)}),
        OpCode("RLC A",nil),
        OpCode("LD (nn),SP",nil),
        OpCode("ADD HL,BC",nil),
        OpCode("LD A,(BC)",nil),
        OpCode("DEC BC",{(cpu: GameBoyCPU) in DEC_rr(cpu, &cpu.registers.B, &cpu.registers.C)}),
        OpCode("INC C",{(cpu: GameBoyCPU) in DEC_r(cpu, &cpu.registers.C)}),
        OpCode("DEC C",{(cpu: GameBoyCPU) in DEC_r(cpu, &cpu.registers.C)}),
        OpCode("LD C,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, &cpu.registers.C)}),
        OpCode("RRC A",nil),
        //0x1n
        OpCode("STOP",nil),
        OpCode("LD DE,nn",nil),
        OpCode("LD (DE),A",nil),
        OpCode("INC DE",nil),
        OpCode("INC D",nil),
        OpCode("DEC D",nil),
        OpCode("LD D,n",nil),
        OpCode("RL A",nil),
        OpCode("JR n",nil),
        OpCode("ADD HL,DE",nil),
        OpCode("LD A,(DE)",nil),
        OpCode("DEC DE",nil),
        OpCode("INC E",nil),
        OpCode("DEC E",nil),
        OpCode("LD E,n",nil),
        OpCode("RR A",nil),
        //0x2n
        OpCode("JR NZ,n",JR_NZ_n),
        OpCode("LD HL,nn",{(cpu: GameBoyCPU) in LD_rr_nn(cpu, &cpu.registers.H, &cpu.registers.L)}),
        OpCode("LDI (HL),A",nil),
        OpCode("INC HL",nil),
        OpCode("INC H",nil),
        OpCode("DEC H",nil),
        OpCode("LD H,n",nil),
        OpCode("DAA",nil),
        OpCode("JR Z,n",nil),
        OpCode("ADD HL,HL",nil),
        OpCode("LDI A,(HL)",LDI_A_aHL),
        OpCode("DEC HL",nil),
        OpCode("INC L",nil),
        OpCode("DEC L",nil),
        OpCode("LD L,n",nil),
        OpCode("CPL",CPL),
        //0x3n
        OpCode("JR NC,n",nil),
        OpCode("LD SP,nn",LD_SP_nn),
        OpCode("LDD (HL),A",LDD_aHL_A),
        OpCode("INC SP",nil),
        OpCode("INC (HL)",nil),
        OpCode("DEC (HL)",nil),
        OpCode("LD (HL),n",LD_aHL_n),
        OpCode("SCF",nil),
        OpCode("JR C,n",nil),
        OpCode("ADD HL,SP",nil),
        OpCode("LDD A,(HL)",nil),
        OpCode("DEC SP",nil),
        OpCode("INC A",nil),
        OpCode("DEC A",nil),
        OpCode("LD A,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, &cpu.registers.A)}),
        OpCode("CCF",nil),
        //0x4n
        OpCode("LD B,B",nil),
        OpCode("LD B,C",nil),
        OpCode("LD B,D",nil),
        OpCode("LD B,E",nil),
        OpCode("LD B,H",nil),
        OpCode("LD B,L",nil),
        OpCode("LD B,(HL)",nil),
        OpCode("LD B,A",nil),
        OpCode("LD C,B",nil),
        OpCode("LD C,C",nil),
        OpCode("LD C,D",nil),
        OpCode("LD C,E",nil),
        OpCode("LD C,H",nil),
        OpCode("LD C,L",nil),
        OpCode("LD C,(HL)",nil),
        OpCode("LD C,A",nil),
        //0x5n
        OpCode("LD D,B",nil),
        OpCode("LD D,C",nil),
        OpCode("LD D,D",nil),
        OpCode("LD D,E",nil),
        OpCode("LD D,H",nil),
        OpCode("LD D,L",nil),
        OpCode("LD D,(HL)",nil),
        OpCode("LD D,A",nil),
        OpCode("LD E,B",nil),
        OpCode("LD E,C",nil),
        OpCode("LD E,D",nil),
        OpCode("LD E,E",nil),
        OpCode("LD E,H",nil),
        OpCode("LD E,L",nil),
        OpCode("LD E,(HL)",nil),
        OpCode("LD E,A",nil),
        //0x6n
        OpCode("LD H,B",nil),
        OpCode("LD H,C",nil),
        OpCode("LD H,D",nil),
        OpCode("LD H,E",nil),
        OpCode("LD H,H",nil),
        OpCode("LD H,L",nil),
        OpCode("LD H,(HL)",nil),
        OpCode("LD H,A",nil),
        OpCode("LD L,B",nil),
        OpCode("LD L,C",nil),
        OpCode("LD L,D",nil),
        OpCode("LD L,E",nil),
        OpCode("LD L,H",nil),
        OpCode("LD L,L",nil),
        OpCode("LD L,(HL)",nil),
        OpCode("LD L,A",nil),
        //0x7n
        OpCode("LD (HL),B",nil),
        OpCode("LD (HL),C",nil),
        OpCode("LD (HL),D",nil),
        OpCode("LD (HL),E",nil),
        OpCode("LD (HL),H",nil),
        OpCode("LD (HL),L",nil),
        OpCode("HALT",nil),
        OpCode("LD (HL),A",nil),
        OpCode("LD A,B",{(cpu: GameBoyCPU) in LD_r_r(cpu, &cpu.registers.A, cpu.registers.B)}),
        OpCode("LD A,C",nil),
        OpCode("LD A,D",nil),
        OpCode("LD A,E",nil),
        OpCode("LD A,H",nil),
        OpCode("LD A,L",nil),
        OpCode("LD A,(HL)",nil),
        OpCode("LD A,A",nil),
        //0x8n
        OpCode("ADD A,B",nil),
        OpCode("ADD A,C",nil),
        OpCode("ADD A,D",nil),
        OpCode("ADD A,E",nil),
        OpCode("ADD A,H",nil),
        OpCode("ADD A,L",nil),
        OpCode("ADD A,(HL)",nil),
        OpCode("ADD A,A",nil),
        OpCode("ADC A,B",nil),
        OpCode("ADC A,C",nil),
        OpCode("ADC A,D",nil),
        OpCode("ADC A,E",nil),
        OpCode("ADC A,H",nil),
        OpCode("ADC A,L",nil),
        OpCode("ADC A,(HL)",nil),
        OpCode("ADC A,A",nil),
        //0x9n
        OpCode("SUB A,B",nil),
        OpCode("SUB A,C",nil),
        OpCode("SUB A,D",nil),
        OpCode("SUB A,E",nil),
        OpCode("SUB A,H",nil),
        OpCode("SUB A,L",nil),
        OpCode("SUB A,(HL)",nil),
        OpCode("SUB A,A",nil),
        OpCode("SBC A,B",nil),
        OpCode("SBC A,C",nil),
        OpCode("SBC A,D",nil),
        OpCode("SBC A,E",nil),
        OpCode("SBC A,H",nil),
        OpCode("SBC A,L",nil),
        OpCode("SBC A,(HL)",nil),
        OpCode("SBC A,A",nil),
        //0xAn
        OpCode("AND B",nil),
        OpCode("AND C",nil),
        OpCode("AND D",nil),
        OpCode("AND E",nil),
        OpCode("AND H",nil),
        OpCode("AND L",nil),
        OpCode("AND (HL)",nil),
        OpCode("AND A",nil),
        OpCode("XOR B",nil),
        OpCode("XOR C",nil),
        OpCode("XOR D",nil),
        OpCode("XOR E",nil),
        OpCode("XOR H",nil),
        OpCode("XOR L",nil),
        OpCode("XOR (HL)",nil),
        OpCode("XOR A",{(cpu: GameBoyCPU) in XOR_r(cpu, &cpu.registers.A)}),
        //0xBn
        OpCode("OR B",nil),
        OpCode("OR C",{(cpu: GameBoyCPU) in OR_r(cpu, &cpu.registers.C)}),
        OpCode("OR D",nil),
        OpCode("OR E",nil),
        OpCode("OR H",nil),
        OpCode("OR L",nil),
        OpCode("OR (HL)",nil),
        OpCode("OR A",nil),
        OpCode("CP B",nil),
        OpCode("CP C",nil),
        OpCode("CP D",nil),
        OpCode("CP E",nil),
        OpCode("CP H",nil),
        OpCode("CP L",nil),
        OpCode("CP (HL)",nil),
        OpCode("CP A",nil),
        //0xCn
        OpCode("RET NZ",nil),
        OpCode("POP BC",nil),
        OpCode("JP NZ,nn",nil),
        OpCode("JP nn",JP_nn),
        OpCode("CALL NZ,nn",nil),
        OpCode("PUSH BC",nil),
        OpCode("ADD A,n",nil),
        OpCode("RST 0",nil),
        OpCode("RET Z",nil),
        OpCode("RET",RET),
        OpCode("JP Z,nn",nil),
        OpCode("Two byte instruction set: Ext ops",EXT_OPCODE),
        OpCode("CALL Z,nn",nil),
        OpCode("CALL nn",CALL_nn),
        OpCode("ADC A,n",nil),
        OpCode("RST 8",nil),
        //0xDn
        OpCode("RET NC",nil),
        OpCode("POP DE",nil),
        OpCode("JP NC,nn",nil),
        OpCode("XX",nil),
        OpCode("CALL NC,nn",nil),
        OpCode("PUSH DE",nil),
        OpCode("SUB A,n",nil),
        OpCode("RST 10",nil),
        OpCode("RET C",nil),
        OpCode("RETI",nil),
        OpCode("JP C,nn",nil),
        OpCode("XX",nil),
        OpCode("CALL C,nn",nil),
        OpCode("XX",nil),
        OpCode("SBC A,n",nil),
        OpCode("RST 18",nil),
        //0xEn
        OpCode("LDH (n),A",LDH_an_A),
        OpCode("POP HL",nil),
        OpCode("LDH (C),A",LDH_aC_A),
        OpCode("XX",nil),
        OpCode("XX",nil),
        OpCode("PUSH HL",nil),
        OpCode("AND n",nil),
        OpCode("RST 20",nil),
        OpCode("ADD SP,d",nil),
        OpCode("JP (HL)",JP_aHL),
        OpCode("LD (nn),A",LD_ann_A),
        OpCode("XX",nil),
        OpCode("XX",nil),
        OpCode("XX",nil),
        OpCode("XOR n",nil),
        OpCode("RST 28",nil),
        //0xFn
        OpCode("LDH A,(n)",LDH_A_an),
        OpCode("POP AF",nil),
        OpCode("XX",nil),
        OpCode("DI",DI),
        OpCode("XX",nil),
        OpCode("PUSH AF",nil),
        OpCode("OR n",nil),
        OpCode("RST 30",nil),
        OpCode("LDHL SP,d",nil),
        OpCode("LD SP,HL",nil),
        OpCode("LD A,(NN)",nil),
        OpCode("EI",nil),
        OpCode("XX",nil),
        OpCode("XX",nil),
        OpCode("CP n",CP_n),
        OpCode("RST 38",nil)]
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
func LD_r_r(cpu: GameBoyCPU, inout _ reg1: UInt8, _ reg2: UInt8) {
    reg1=reg2
    cpu.registers.PC++
    cpu.updateClock(1)
}
// load from imediate to register
func LD_r_n(cpu: GameBoyCPU, inout _ reg: UInt8) {
    reg = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.registers.PC+=2
    cpu.updateClock(2)
}
// load from address in HL to register
func LD_r_aHL(cpu: GameBoyCPU, inout _ reg: UInt8) {
    reg = cpu.memory.read(address: cpu.registers.getHL())
    cpu.registers.PC++
    cpu.updateClock(2)
}
// load from register to address in HL
func LD_aHL_r(cpu: GameBoyCPU, reg: UInt8) {
    let addr = cpu.registers.getHL()
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
    let addr = cpu.registers.get16(regH,regL)
    cpu.registers.A = cpu.memory.read(address: addr)
    cpu.registers.PC++
    cpu.updateClock(2)
}
// load from address in 16bit imediate to A
func LD_A_ann(cpu: GameBoyCPU) {
    let addr = cpu.memory.read16(address: cpu.registers.PC+1)
    cpu.registers.A = cpu.memory.read(address: addr)
    cpu.registers.PC+=3
    cpu.updateClock(4)
}


func LD_rr_nn(cpu: GameBoyCPU, inout _ regH: UInt8, inout _ regL: UInt8) {
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
        let num = cpu.memory.read(address: cpu.registers.PC+1)
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
func DEC_r(cpu: GameBoyCPU, inout _ reg: UInt8) {
    //flags
    cpu.registers.F = F_NEGATIVE
    if reg == 0x01 { cpu.registers.F |= F_ZERO }
    if reg & 0x0F == 0 { cpu.registers.F |= F_HALF_CARRY }
    reg = reg &- 1
    cpu.registers.PC++
    cpu.updateClock(1)
}

func DEC_rr(cpu: GameBoyCPU, inout _ regH: UInt8, inout _ regL: UInt8) {
    var value = cpu.registers.get16(regH, regL)
    value = value &- 1
    cpu.registers.setBC(value)
    cpu.registers.PC++
    cpu.updateClock(2)
}
func INC_r(cpu: GameBoyCPU, inout _ reg: UInt8) {
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
func OR_r(cpu: GameBoyCPU, inout _ reg: UInt8) {
    cpu.registers.A |= reg
    cpu.registers.F = cpu.registers.A == 0 ? F_ZERO : 0
    cpu.registers.PC++
    cpu.updateClock(1)
}
func XOR_r(cpu: GameBoyCPU, inout _ reg: UInt8) {
    cpu.registers.A ^= reg
    cpu.registers.F = cpu.registers.A == 0 ? F_ZERO : 0
    cpu.registers.PC++
    cpu.updateClock(1)
}

// 16 bit opcodes
func EXT_OPCODE(cpu: GameBoyCPU) {
    let instr = cpu.memory.read(address: cpu.registers.PC+1)
    print("ERROR: extended instructions not yet implemented!")
    exit(-1)
}
