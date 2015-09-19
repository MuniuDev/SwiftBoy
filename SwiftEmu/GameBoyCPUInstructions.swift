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
    let table = [
        //0x0n
        OpCode("NOP",NOP),
        OpCode("LD BC,nn",{(cpu: GameBoyCPU) in LD_rr_nn(cpu, regH: &cpu.registers.B, regL: &cpu.registers.C)}),
        OpCode("LD (BC),A",nil),
        OpCode("INC BC",nil),
        OpCode("INC B",{(cpu: GameBoyCPU) in INC_r(cpu, reg: &cpu.registers.B)}),
        OpCode("DEC B",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.B)}),
        OpCode("LD B,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, reg: &cpu.registers.B)}),
        OpCode("RLC A",nil),
        OpCode("LD (nn),SP",nil),
        OpCode("ADD HL,BC",nil),
        OpCode("LD A,(BC)",{(cpu: GameBoyCPU) in LD_A_arr(cpu, regH: cpu.registers.B, regL: cpu.registers.C)}),
        OpCode("DEC BC",{(cpu: GameBoyCPU) in DEC_rr(cpu, regH: &cpu.registers.B, regL: &cpu.registers.C)}),
        OpCode("INC C",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.C)}),
        OpCode("DEC C",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.C)}),
        OpCode("LD C,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, reg: &cpu.registers.C)}),
        OpCode("RRC A",nil),
        //0x1n
        OpCode("STOP",nil),
        OpCode("LD DE,nn",{(cpu: GameBoyCPU) in LD_rr_nn(cpu, regH: &cpu.registers.D, regL: &cpu.registers.E) }),
        OpCode("LD (DE),A",nil),
        OpCode("INC DE",nil),
        OpCode("INC D",{(cpu: GameBoyCPU) in INC_r(cpu, reg: &cpu.registers.D)}),
        OpCode("DEC D",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.D)}),
        OpCode("LD D,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, reg: &cpu.registers.D)}),
        OpCode("RL A",nil),
        OpCode("JR n",nil),
        OpCode("ADD HL,DE",nil),
        OpCode("LD A,(DE)",{(cpu: GameBoyCPU) in LD_A_arr(cpu, regH: cpu.registers.D, regL: cpu.registers.E)}),
        OpCode("DEC DE",nil),
        OpCode("INC E",{(cpu: GameBoyCPU) in INC_r(cpu, reg: &cpu.registers.E)}),
        OpCode("DEC E",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.E)}),
        OpCode("LD E,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, reg: &cpu.registers.E)}),
        OpCode("RR A",nil),
        //0x2n
        OpCode("JR NZ,n",JR_NZ_n),
        OpCode("LD HL,nn",{(cpu: GameBoyCPU) in LD_rr_nn(cpu, regH: &cpu.registers.H, regL: &cpu.registers.L)}),
        OpCode("LDI (HL),A",nil),
        OpCode("INC HL",nil),
        OpCode("INC H",{(cpu: GameBoyCPU) in INC_r(cpu, reg: &cpu.registers.H)}),
        OpCode("DEC H",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.H)}),
        OpCode("LD H,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, reg: &cpu.registers.H)}),
        OpCode("DAA",nil),
        OpCode("JR Z,n",nil),
        OpCode("ADD HL,HL",nil),
        OpCode("LDI A,(HL)",LDI_A_aHL),
        OpCode("DEC HL",nil),
        OpCode("INC L",{(cpu: GameBoyCPU) in INC_r(cpu, reg: &cpu.registers.L)}),
        OpCode("DEC L",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.L)}),
        OpCode("LD L,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, reg: &cpu.registers.L)}),
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
        OpCode("INC A",{(cpu: GameBoyCPU) in INC_r(cpu, reg: &cpu.registers.A)}),
        OpCode("DEC A",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.A)}),
        OpCode("LD A,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, reg: &cpu.registers.A)}),
        OpCode("CCF",nil),
        //0x4n
        OpCode("LD B,B",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.B, reg2: cpu.registers.B)}),
        OpCode("LD B,C",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.B, reg2: cpu.registers.C)}),
        OpCode("LD B,D",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.B, reg2: cpu.registers.D)}),
        OpCode("LD B,E",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.B, reg2: cpu.registers.E)}),
        OpCode("LD B,H",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.B, reg2: cpu.registers.H)}),
        OpCode("LD B,L",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.B, reg2: cpu.registers.L)}),
        OpCode("LD B,(HL)",{(cpu: GameBoyCPU) in LD_r_aHL(cpu, reg: &cpu.registers.B)}),
        OpCode("LD B,A",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.B, reg2: cpu.registers.A)}),
        OpCode("LD C,B",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.C, reg2: cpu.registers.B)}),
        OpCode("LD C,C",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.C, reg2: cpu.registers.C)}),
        OpCode("LD C,D",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.C, reg2: cpu.registers.D)}),
        OpCode("LD C,E",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.C, reg2: cpu.registers.E)}),
        OpCode("LD C,H",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.C, reg2: cpu.registers.H)}),
        OpCode("LD C,L",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.C, reg2: cpu.registers.L)}),
        OpCode("LD C,(HL)",{(cpu: GameBoyCPU) in LD_r_aHL(cpu, reg: &cpu.registers.C)}),
        OpCode("LD C,A",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.C, reg2: cpu.registers.A)}),
        //0x5n
        OpCode("LD D,B",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.D, reg2: cpu.registers.B)}),
        OpCode("LD D,C",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.D, reg2: cpu.registers.C)}),
        OpCode("LD D,D",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.D, reg2: cpu.registers.D)}),
        OpCode("LD D,E",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.D, reg2: cpu.registers.E)}),
        OpCode("LD D,H",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.D, reg2: cpu.registers.H)}),
        OpCode("LD D,L",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.D, reg2: cpu.registers.L)}),
        OpCode("LD D,(HL)",{(cpu: GameBoyCPU) in LD_r_aHL(cpu, reg: &cpu.registers.D)}),
        OpCode("LD D,A",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.D, reg2: cpu.registers.A)}),
        OpCode("LD E,B",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.E, reg2: cpu.registers.B)}),
        OpCode("LD E,C",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.E, reg2: cpu.registers.C)}),
        OpCode("LD E,D",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.E, reg2: cpu.registers.D)}),
        OpCode("LD E,E",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.E, reg2: cpu.registers.E)}),
        OpCode("LD E,H",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.E, reg2: cpu.registers.H)}),
        OpCode("LD E,L",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.E, reg2: cpu.registers.L)}),
        OpCode("LD E,(HL)",{(cpu: GameBoyCPU) in LD_r_aHL(cpu, reg: &cpu.registers.E)}),
        OpCode("LD E,A",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.E, reg2: cpu.registers.A)}),
        //0x6n
        OpCode("LD H,B",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.H, reg2: cpu.registers.B)}),
        OpCode("LD H,C",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.H, reg2: cpu.registers.C)}),
        OpCode("LD H,D",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.H, reg2: cpu.registers.D)}),
        OpCode("LD H,E",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.H, reg2: cpu.registers.E)}),
        OpCode("LD H,H",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.H, reg2: cpu.registers.H)}),
        OpCode("LD H,L",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.H, reg2: cpu.registers.L)}),
        OpCode("LD H,(HL)",{(cpu: GameBoyCPU) in LD_r_aHL(cpu, reg: &cpu.registers.H)}),
        OpCode("LD H,A",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.H, reg2: cpu.registers.A)}),
        OpCode("LD L,B",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.L, reg2: cpu.registers.B)}),
        OpCode("LD L,C",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.L, reg2: cpu.registers.C)}),
        OpCode("LD L,D",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.L, reg2: cpu.registers.D)}),
        OpCode("LD L,E",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.L, reg2: cpu.registers.E)}),
        OpCode("LD L,H",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.L, reg2: cpu.registers.H)}),
        OpCode("LD L,L",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.L, reg2: cpu.registers.L)}),
        OpCode("LD L,(HL)",{(cpu: GameBoyCPU) in LD_r_aHL(cpu, reg: &cpu.registers.L)}),
        OpCode("LD L,A",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.L, reg2: cpu.registers.A)}),
        //0x7n
        OpCode("LD (HL),B",{(cpu: GameBoyCPU) in LD_aHL_r(cpu,reg: cpu.registers.B)}),
        OpCode("LD (HL),C",{(cpu: GameBoyCPU) in LD_aHL_r(cpu,reg: cpu.registers.C)}),
        OpCode("LD (HL),D",{(cpu: GameBoyCPU) in LD_aHL_r(cpu,reg: cpu.registers.D)}),
        OpCode("LD (HL),E",{(cpu: GameBoyCPU) in LD_aHL_r(cpu,reg: cpu.registers.E)}),
        OpCode("LD (HL),H",{(cpu: GameBoyCPU) in LD_aHL_r(cpu,reg: cpu.registers.H)}),
        OpCode("LD (HL),L",{(cpu: GameBoyCPU) in LD_aHL_r(cpu,reg: cpu.registers.L)}),
        OpCode("HALT",nil),
        OpCode("LD (HL),A",{(cpu: GameBoyCPU) in LD_aHL_r(cpu,reg: cpu.registers.A)}),
        OpCode("LD A,B",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.A, reg2: cpu.registers.B)}),
        OpCode("LD A,C",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.A, reg2: cpu.registers.C)}),
        OpCode("LD A,D",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.A, reg2: cpu.registers.D)}),
        OpCode("LD A,E",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.A, reg2: cpu.registers.E)}),
        OpCode("LD A,H",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.A, reg2: cpu.registers.H)}),
        OpCode("LD A,L",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.A, reg2: cpu.registers.L)}),
        OpCode("LD A,(HL)",{(cpu: GameBoyCPU) in LD_r_aHL(cpu, reg: &cpu.registers.A)}),
        OpCode("LD A,A",{(cpu: GameBoyCPU) in LD_r_r(cpu, reg1: &cpu.registers.A, reg2: cpu.registers.A)}),
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
        OpCode("XOR B",{(cpu: GameBoyCPU) in XOR_r(cpu, reg: &cpu.registers.B)}),
        OpCode("XOR C",{(cpu: GameBoyCPU) in XOR_r(cpu, reg: &cpu.registers.C)}),
        OpCode("XOR D",{(cpu: GameBoyCPU) in XOR_r(cpu, reg: &cpu.registers.D)}),
        OpCode("XOR E",{(cpu: GameBoyCPU) in XOR_r(cpu, reg: &cpu.registers.E)}),
        OpCode("XOR H",{(cpu: GameBoyCPU) in XOR_r(cpu, reg: &cpu.registers.H)}),
        OpCode("XOR L",{(cpu: GameBoyCPU) in XOR_r(cpu, reg: &cpu.registers.L)}),
        OpCode("XOR (HL)",nil),
        OpCode("XOR A",{(cpu: GameBoyCPU) in XOR_r(cpu, reg: &cpu.registers.A)}),
        //0xBn
        OpCode("OR B",{(cpu: GameBoyCPU) in OR_r(cpu, reg: &cpu.registers.B)}),
        OpCode("OR C",{(cpu: GameBoyCPU) in OR_r(cpu, reg: &cpu.registers.C)}),
        OpCode("OR D",{(cpu: GameBoyCPU) in OR_r(cpu, reg: &cpu.registers.D)}),
        OpCode("OR E",{(cpu: GameBoyCPU) in OR_r(cpu, reg: &cpu.registers.E)}),
        OpCode("OR H",{(cpu: GameBoyCPU) in OR_r(cpu, reg: &cpu.registers.H)}),
        OpCode("OR L",{(cpu: GameBoyCPU) in OR_r(cpu, reg: &cpu.registers.L)}),
        OpCode("OR (HL)",nil),
        OpCode("OR A",{(cpu: GameBoyCPU) in OR_r(cpu, reg: &cpu.registers.A)}),
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
        OpCode("LD A,(NN)",LD_A_ann),
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
    //TODO implement interrupts
    cpu.registers.PC++
    cpu.updateClock(1)
}

// loading
// load from register to register
func LD_r_r(cpu: GameBoyCPU, inout reg1: UInt8, reg2: UInt8) {
    reg1 = reg2
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
// load from 16-bit imediate to register pair
func LD_rr_nn(cpu: GameBoyCPU, inout regH: UInt8, inout regL: UInt8) {
    cpu.registers.set16(&regH, &regL, value: cpu.memory.read16(address: cpu.registers.PC+1))
    cpu.registers.PC+=3
    cpu.updateClock(3)
}
// load from 16-bit imediate to stack pointer
func LD_SP_nn(cpu: GameBoyCPU) {
    cpu.registers.SP = cpu.memory.read16(address: cpu.registers.PC+1)
    cpu.registers.PC+=3
    cpu.updateClock(3)
}


///////// functions below are not redesigned!!!

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
func XOR_r(cpu: GameBoyCPU, inout
    reg: UInt8) {
    cpu.registers.A ^= reg
    cpu.registers.F = cpu.registers.A == 0 ? F_ZERO : 0
    cpu.registers.PC++
    cpu.updateClock(1)
}

// 16 bit opcodes
func EXT_OPCODE(cpu: GameBoyCPU) {
    let extOpCodeVal = cpu.memory.read(address: cpu.registers.PC+1)
    let extOpCode = cpu.extOpcodes[Int(extOpCodeVal)]
    
    if extOpCode.instruction != nil {
        print("Called: \"" + extOpCode.name + "\" of code: 0x" + String(format:"%2X", extOpCodeVal) + ". PC=" + String(format:"%4X",cpu.registers.PC+1))
        extOpCode.instruction!(cpu: cpu)
    } else {
        print("ERROR: Unimplemented instruction \"" + extOpCode.name + "\" of code: 0x" + String(format:"%2X", extOpCodeVal) + ".")
        exit(-1)
    }
}


