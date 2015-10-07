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
        OpCode("LD (BC),A",{(cpu: GameBoyCPU) in LD_arr_A(cpu, regH: cpu.registers.B, regL: cpu.registers.C)}),
        OpCode("INC BC",{(cpu: GameBoyCPU) in INC_rr(cpu, regH: &cpu.registers.B, regL: &cpu.registers.C)}),
        OpCode("INC B",{(cpu: GameBoyCPU) in INC_r(cpu, reg: &cpu.registers.B)}),
        OpCode("DEC B",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.B)}),
        OpCode("LD B,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, reg: &cpu.registers.B)}),
        OpCode("RLC A",{(cpu: GameBoyCPU) in RLC_r(cpu, reg: &cpu.registers.A); cpu.registers.PC--}),
        OpCode("LD (nn),SP",LD_ann_SP),
        OpCode("ADD HL,BC",{(cpu: GameBoyCPU) in ADD_HL_rr(cpu, regH: cpu.registers.B, regL: cpu.registers.C)}),
        OpCode("LD A,(BC)",{(cpu: GameBoyCPU) in LD_A_arr(cpu, regH: cpu.registers.B, regL: cpu.registers.C)}),
        OpCode("DEC BC",{(cpu: GameBoyCPU) in DEC_rr(cpu, regH: &cpu.registers.B, regL: &cpu.registers.C)}),
        OpCode("INC C",{(cpu: GameBoyCPU) in INC_r(cpu, reg: &cpu.registers.C)}),
        OpCode("DEC C",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.C)}),
        OpCode("LD C,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, reg: &cpu.registers.C)}),
        OpCode("RRC A",{(cpu: GameBoyCPU) in RRC_r(cpu, reg: &cpu.registers.A); cpu.registers.PC--}),
        //0x1n
        OpCode("STOP",nil),
        OpCode("LD DE,nn",{(cpu: GameBoyCPU) in LD_rr_nn(cpu, regH: &cpu.registers.D, regL: &cpu.registers.E) }),
        OpCode("LD (DE),A",{(cpu: GameBoyCPU) in LD_arr_A(cpu, regH: cpu.registers.D, regL: cpu.registers.E)}),
        OpCode("INC DE",{(cpu: GameBoyCPU) in INC_rr(cpu, regH: &cpu.registers.D, regL: &cpu.registers.E)}),
        OpCode("INC D",{(cpu: GameBoyCPU) in INC_r(cpu, reg: &cpu.registers.D)}),
        OpCode("DEC D",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.D)}),
        OpCode("LD D,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, reg: &cpu.registers.D)}),
        OpCode("RL A",{(cpu: GameBoyCPU) in RL_r(cpu, reg: &cpu.registers.A); cpu.registers.PC--}),
        OpCode("JR e",JR_e),
        OpCode("ADD HL,DE",{(cpu: GameBoyCPU) in ADD_HL_rr(cpu, regH: cpu.registers.D, regL: cpu.registers.E)}),
        OpCode("LD A,(DE)",{(cpu: GameBoyCPU) in LD_A_arr(cpu, regH: cpu.registers.D, regL: cpu.registers.E)}),
        OpCode("DEC DE",{(cpu: GameBoyCPU) in DEC_rr(cpu, regH: &cpu.registers.D, regL: &cpu.registers.E)}),
        OpCode("INC E",{(cpu: GameBoyCPU) in INC_r(cpu, reg: &cpu.registers.E)}),
        OpCode("DEC E",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.E)}),
        OpCode("LD E,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, reg: &cpu.registers.E)}),
        OpCode("RR A",{(cpu: GameBoyCPU) in RR_r(cpu, reg: &cpu.registers.A); cpu.registers.PC--}),
        //0x2n
        OpCode("JR NZ,e",{(cpu: GameBoyCPU) in JR_cc_e(cpu, condition: !cpu.registers.checkZero())}),
        OpCode("LD HL,nn",{(cpu: GameBoyCPU) in LD_rr_nn(cpu, regH: &cpu.registers.H, regL: &cpu.registers.L)}),
        OpCode("LDI (HL),A",LDI_aHL_A),
        OpCode("INC HL",{(cpu: GameBoyCPU) in INC_rr(cpu, regH: &cpu.registers.H, regL: &cpu.registers.L)}),
        OpCode("INC H",{(cpu: GameBoyCPU) in INC_r(cpu, reg: &cpu.registers.H)}),
        OpCode("DEC H",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.H)}),
        OpCode("LD H,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, reg: &cpu.registers.H)}),
        OpCode("DAA",DAA),
        OpCode("JR Z,e",{(cpu: GameBoyCPU) in JR_cc_e(cpu, condition: cpu.registers.checkZero())}),
        OpCode("ADD HL,HL",{(cpu: GameBoyCPU) in ADD_HL_rr(cpu, regH: cpu.registers.H, regL: cpu.registers.L)}),
        OpCode("LDI A,(HL)",LDI_A_aHL),
        OpCode("DEC HL",{(cpu: GameBoyCPU) in DEC_rr(cpu, regH: &cpu.registers.H, regL: &cpu.registers.L)}),
        OpCode("INC L",{(cpu: GameBoyCPU) in INC_r(cpu, reg: &cpu.registers.L)}),
        OpCode("DEC L",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.L)}),
        OpCode("LD L,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, reg: &cpu.registers.L)}),
        OpCode("CPL",CPL),
        //0x3n
        OpCode("JR NC,e",{(cpu: GameBoyCPU) in JR_cc_e(cpu, condition: !cpu.registers.checkCarry())}),
        OpCode("LD SP,nn",LD_SP_nn),
        OpCode("LDD (HL),A",LDD_aHL_A),
        OpCode("INC SP",INC_SP),
        OpCode("INC (HL)",INC_aHL),
        OpCode("DEC (HL)",DEC_aHL),
        OpCode("LD (HL),n",LD_aHL_n),
        OpCode("SCF",SCF),
        OpCode("JR C,e",{(cpu: GameBoyCPU) in JR_cc_e(cpu, condition: cpu.registers.checkCarry())}),
        OpCode("ADD HL,SP",{(cpu: GameBoyCPU) in ADD_HL_rr(cpu, regH: UInt8(cpu.registers.SP >> 8), regL: UInt8(cpu.registers.SP & 0xFF))}),
        OpCode("LDD A,(HL)",LDD_A_aHL),
        OpCode("DEC SP",DEC_SP),
        OpCode("INC A",{(cpu: GameBoyCPU) in INC_r(cpu, reg: &cpu.registers.A)}),
        OpCode("DEC A",{(cpu: GameBoyCPU) in DEC_r(cpu, reg: &cpu.registers.A)}),
        OpCode("LD A,n",{(cpu: GameBoyCPU) in LD_r_n(cpu, reg: &cpu.registers.A)}),
        OpCode("CCF",CCF),
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
        OpCode("ADD A,B",{(cpu: GameBoyCPU) in ADD_A_r(cpu, reg: cpu.registers.B)}),
        OpCode("ADD A,C",{(cpu: GameBoyCPU) in ADD_A_r(cpu, reg: cpu.registers.C)}),
        OpCode("ADD A,D",{(cpu: GameBoyCPU) in ADD_A_r(cpu, reg: cpu.registers.D)}),
        OpCode("ADD A,E",{(cpu: GameBoyCPU) in ADD_A_r(cpu, reg: cpu.registers.E)}),
        OpCode("ADD A,H",{(cpu: GameBoyCPU) in ADD_A_r(cpu, reg: cpu.registers.H)}),
        OpCode("ADD A,L",{(cpu: GameBoyCPU) in ADD_A_r(cpu, reg: cpu.registers.L)}),
        OpCode("ADD A,(HL)",ADD_A_aHL),
        OpCode("ADD A,A",{(cpu: GameBoyCPU) in ADD_A_r(cpu, reg: cpu.registers.A)}),
        OpCode("ADC A,B",{(cpu: GameBoyCPU) in ADC_A_r(cpu, reg: cpu.registers.B)}),
        OpCode("ADC A,C",{(cpu: GameBoyCPU) in ADC_A_r(cpu, reg: cpu.registers.C)}),
        OpCode("ADC A,D",{(cpu: GameBoyCPU) in ADC_A_r(cpu, reg: cpu.registers.D)}),
        OpCode("ADC A,E",{(cpu: GameBoyCPU) in ADC_A_r(cpu, reg: cpu.registers.E)}),
        OpCode("ADC A,H",{(cpu: GameBoyCPU) in ADC_A_r(cpu, reg: cpu.registers.H)}),
        OpCode("ADC A,L",{(cpu: GameBoyCPU) in ADC_A_r(cpu, reg: cpu.registers.L)}),
        OpCode("ADC A,(HL)",ADC_A_aHL),
        OpCode("ADC A,A",{(cpu: GameBoyCPU) in ADC_A_r(cpu, reg: cpu.registers.A)}),
        //0x9n
        OpCode("SUB A,B",{(cpu: GameBoyCPU) in SUB_A_r(cpu, reg: cpu.registers.B)}),
        OpCode("SUB A,C",{(cpu: GameBoyCPU) in SUB_A_r(cpu, reg: cpu.registers.C)}),
        OpCode("SUB A,D",{(cpu: GameBoyCPU) in SUB_A_r(cpu, reg: cpu.registers.D)}),
        OpCode("SUB A,E",{(cpu: GameBoyCPU) in SUB_A_r(cpu, reg: cpu.registers.E)}),
        OpCode("SUB A,H",{(cpu: GameBoyCPU) in SUB_A_r(cpu, reg: cpu.registers.H)}),
        OpCode("SUB A,L",{(cpu: GameBoyCPU) in SUB_A_r(cpu, reg: cpu.registers.L)}),
        OpCode("SUB A,(HL)",SUB_A_aHL),
        OpCode("SUB A,A",{(cpu: GameBoyCPU) in SUB_A_r(cpu, reg: cpu.registers.A)}),
        OpCode("SBC A,B",{(cpu: GameBoyCPU) in SBC_A_r(cpu, reg: cpu.registers.B)}),
        OpCode("SBC A,C",{(cpu: GameBoyCPU) in SBC_A_r(cpu, reg: cpu.registers.C)}),
        OpCode("SBC A,D",{(cpu: GameBoyCPU) in SBC_A_r(cpu, reg: cpu.registers.D)}),
        OpCode("SBC A,E",{(cpu: GameBoyCPU) in SBC_A_r(cpu, reg: cpu.registers.E)}),
        OpCode("SBC A,H",{(cpu: GameBoyCPU) in SBC_A_r(cpu, reg: cpu.registers.H)}),
        OpCode("SBC A,L",{(cpu: GameBoyCPU) in SBC_A_r(cpu, reg: cpu.registers.L)}),
        OpCode("SBC A,(HL)",SBC_A_aHL),
        OpCode("SBC A,A",{(cpu: GameBoyCPU) in SBC_A_r(cpu, reg: cpu.registers.A)}),
        //0xAn
        OpCode("AND B",{(cpu: GameBoyCPU) in AND_r(cpu, reg: cpu.registers.B)}),
        OpCode("AND C",{(cpu: GameBoyCPU) in AND_r(cpu, reg: cpu.registers.C)}),
        OpCode("AND D",{(cpu: GameBoyCPU) in AND_r(cpu, reg: cpu.registers.D)}),
        OpCode("AND E",{(cpu: GameBoyCPU) in AND_r(cpu, reg: cpu.registers.E)}),
        OpCode("AND H",{(cpu: GameBoyCPU) in AND_r(cpu, reg: cpu.registers.H)}),
        OpCode("AND L",{(cpu: GameBoyCPU) in AND_r(cpu, reg: cpu.registers.L)}),
        OpCode("AND (HL)",AND_aHL),
        OpCode("AND A",{(cpu: GameBoyCPU) in AND_r(cpu, reg: cpu.registers.A)}),
        OpCode("XOR B",{(cpu: GameBoyCPU) in XOR_r(cpu, reg: cpu.registers.B)}),
        OpCode("XOR C",{(cpu: GameBoyCPU) in XOR_r(cpu, reg: cpu.registers.C)}),
        OpCode("XOR D",{(cpu: GameBoyCPU) in XOR_r(cpu, reg: cpu.registers.D)}),
        OpCode("XOR E",{(cpu: GameBoyCPU) in XOR_r(cpu, reg: cpu.registers.E)}),
        OpCode("XOR H",{(cpu: GameBoyCPU) in XOR_r(cpu, reg: cpu.registers.H)}),
        OpCode("XOR L",{(cpu: GameBoyCPU) in XOR_r(cpu, reg: cpu.registers.L)}),
        OpCode("XOR (HL)",XOR_aHL),
        OpCode("XOR A",{(cpu: GameBoyCPU) in XOR_r(cpu, reg: cpu.registers.A)}),
        //0xBn
        OpCode("OR B",{(cpu: GameBoyCPU) in OR_r(cpu, reg: cpu.registers.B)}),
        OpCode("OR C",{(cpu: GameBoyCPU) in OR_r(cpu, reg: cpu.registers.C)}),
        OpCode("OR D",{(cpu: GameBoyCPU) in OR_r(cpu, reg: cpu.registers.D)}),
        OpCode("OR E",{(cpu: GameBoyCPU) in OR_r(cpu, reg: cpu.registers.E)}),
        OpCode("OR H",{(cpu: GameBoyCPU) in OR_r(cpu, reg: cpu.registers.H)}),
        OpCode("OR L",{(cpu: GameBoyCPU) in OR_r(cpu, reg: cpu.registers.L)}),
        OpCode("OR (HL)",OR_aHL),
        OpCode("OR A",{(cpu: GameBoyCPU) in OR_r(cpu, reg: cpu.registers.A)}),
        OpCode("CP B",{(cpu: GameBoyCPU) in CP_r(cpu, reg: cpu.registers.B)}),
        OpCode("CP C",{(cpu: GameBoyCPU) in CP_r(cpu, reg: cpu.registers.C)}),
        OpCode("CP D",{(cpu: GameBoyCPU) in CP_r(cpu, reg: cpu.registers.D)}),
        OpCode("CP E",{(cpu: GameBoyCPU) in CP_r(cpu, reg: cpu.registers.E)}),
        OpCode("CP H",{(cpu: GameBoyCPU) in CP_r(cpu, reg: cpu.registers.H)}),
        OpCode("CP L",{(cpu: GameBoyCPU) in CP_r(cpu, reg: cpu.registers.L)}),
        OpCode("CP (HL)",CP_aHL),
        OpCode("CP A",{(cpu: GameBoyCPU) in CP_r(cpu, reg: cpu.registers.A)}),
        //0xCn
        OpCode("RET NZ",{(cpu: GameBoyCPU) in RET_cc(cpu, condition: !cpu.registers.checkZero())}),
        OpCode("POP BC",{(cpu: GameBoyCPU) in POP_rr(cpu, regH: &cpu.registers.B, regL: &cpu.registers.C)}),
        OpCode("JP NZ,nn",{(cpu: GameBoyCPU) in JP_cc_nn(cpu, condition: !cpu.registers.checkZero())}),
        OpCode("JP nn",JP_nn),
        OpCode("CALL NZ,nn",{(cpu: GameBoyCPU) in CALL_cc_nn(cpu, condition: !cpu.registers.checkZero())}),
        OpCode("PUSH BC",{(cpu: GameBoyCPU) in PUSH_rr(cpu, regH: cpu.registers.B, regL: cpu.registers.C)}),
        OpCode("ADD A,n",ADD_A_n),
        OpCode("RST 0",{(cpu: GameBoyCPU) in RST_t(cpu, t: 0x00)}),
        OpCode("RET Z",{(cpu: GameBoyCPU) in RET_cc(cpu, condition: cpu.registers.checkZero())}),
        OpCode("RET",RET),
        OpCode("JP Z,nn",{(cpu: GameBoyCPU) in JP_cc_nn(cpu, condition: cpu.registers.checkZero())}),
        OpCode("Two byte instruction set: Ext ops",EXT_OPCODE),
        OpCode("CALL Z,nn",{(cpu: GameBoyCPU) in CALL_cc_nn(cpu, condition: cpu.registers.checkZero())}),
        OpCode("CALL nn",CALL_nn),
        OpCode("ADC A,n",ADC_A_n),
        OpCode("RST 8",{(cpu: GameBoyCPU) in RST_t(cpu, t: 0x08)}),
        //0xDn
        OpCode("RET NC",{(cpu: GameBoyCPU) in RET_cc(cpu, condition: !cpu.registers.checkCarry())}),
        OpCode("POP DE",{(cpu: GameBoyCPU) in POP_rr(cpu, regH: &cpu.registers.D, regL: &cpu.registers.E)}),
        OpCode("JP NC,nn",{(cpu: GameBoyCPU) in JP_cc_nn(cpu, condition: !cpu.registers.checkCarry())}),
        OpCode("XX",nil),
        OpCode("CALL NC,nn",{(cpu: GameBoyCPU) in CALL_cc_nn(cpu, condition: !cpu.registers.checkCarry())}),
        OpCode("PUSH DE",{(cpu: GameBoyCPU) in PUSH_rr(cpu, regH: cpu.registers.D, regL: cpu.registers.E)}),
        OpCode("SUB A,n",SUB_A_n),
        OpCode("RST 10",{(cpu: GameBoyCPU) in RST_t(cpu, t: 0x10)}),
        OpCode("RET C",{(cpu: GameBoyCPU) in RET_cc(cpu, condition: cpu.registers.checkCarry())}),
        OpCode("RETI",RETI),
        OpCode("JP C,nn",{(cpu: GameBoyCPU) in JP_cc_nn(cpu, condition: cpu.registers.checkCarry())}),
        OpCode("XX",nil),
        OpCode("CALL C,nn",{(cpu: GameBoyCPU) in CALL_cc_nn(cpu, condition: cpu.registers.checkCarry())}),
        OpCode("XX",nil),
        OpCode("SBC A,n",SBC_A_n),
        OpCode("RST 18",{(cpu: GameBoyCPU) in RST_t(cpu, t: 0x18)}),
        //0xEn
        OpCode("LDH (n),A",LDH_an_A),
        OpCode("POP HL",{(cpu: GameBoyCPU) in POP_rr(cpu, regH: &cpu.registers.H, regL: &cpu.registers.L)}),
        OpCode("LDH (C),A",LDH_aC_A),
        OpCode("XX",nil),
        OpCode("XX",nil),
        OpCode("PUSH HL",{(cpu: GameBoyCPU) in PUSH_rr(cpu, regH: cpu.registers.H, regL: cpu.registers.L)}),
        OpCode("AND n",AND_n),
        OpCode("RST 20",{(cpu: GameBoyCPU) in RST_t(cpu, t: 0x20)}),
        OpCode("ADD SP,e",ADD_SP_e),
        OpCode("JP (HL)",JP_aHL),
        OpCode("LD (nn),A",LD_ann_A),
        OpCode("XX",nil),
        OpCode("XX",nil),
        OpCode("XX",nil),
        OpCode("XOR n",XOR_n),
        OpCode("RST 28",{(cpu: GameBoyCPU) in RST_t(cpu, t: 0x28)}),
        //0xFn
        OpCode("LDH A,(n)",LDH_A_an),
        OpCode("POP AF",{(cpu: GameBoyCPU) in POP_rr(cpu, regH: &cpu.registers.A, regL: &cpu.registers.F)}),
        OpCode("XX",nil),
        OpCode("DI",DI),
        OpCode("XX",nil),
        OpCode("PUSH AF",{(cpu: GameBoyCPU) in PUSH_rr(cpu, regH: cpu.registers.A, regL: cpu.registers.F)}),
        OpCode("OR n",OR_n),
        OpCode("RST 30",{(cpu: GameBoyCPU) in RST_t(cpu, t: 0x30)}),
        OpCode("LDHL SP,e",LDHL_SP_e),
        OpCode("LD SP,HL",LD_SP_HL),
        OpCode("LD A,(NN)",LD_A_ann),
        OpCode("EI",EI),
        OpCode("XX",nil),
        OpCode("XX",nil),
        OpCode("CP n",CP_n),
        OpCode("RST 38",{(cpu: GameBoyCPU) in RST_t(cpu, t: 0x38)})]
    return table
}

//TODO implement HALT and STOP instr.

//instructions
func NOP(cpu: GameBoyCPU) {
    cpu.registers.PC++
    cpu.updateClock(1)
}
// disable interrupts
func DI(cpu: GameBoyCPU) {
    cpu.interruptMasterFlag = false
    cpu.registers.PC++
    cpu.updateClock(1)
}
// enable interrupts
func EI(cpu: GameBoyCPU) {
    cpu.interruptMasterFlag = true
    cpu.registers.PC++
    cpu.updateClock(1)
}
// set carry flag
func SCF(cpu: GameBoyCPU) {
    cpu.registers.F &= GameBoyRegisters.F_ZERO
    cpu.registers.F |= GameBoyRegisters.F_CARRY
    cpu.registers.PC++
    cpu.updateClock(1)
}
// clear carry flag
func CCF(cpu: GameBoyCPU) {
    cpu.registers.F = GameBoyRegisters.F_ZERO | ((~cpu.registers.F) & GameBoyRegisters.F_CARRY)
    cpu.registers.PC++
    cpu.updateClock(1)
}
// push register pair to stack
func PUSH_rr(cpu: GameBoyCPU, regH: UInt8, regL: UInt8) {
    let val = GameBoyRegisters.get16(regH, regL)
    cpu.memory.write16(address: cpu.registers.SP-2, value: val)
    cpu.registers.SP -= 2;
    cpu.registers.PC++
    cpu.updateClock(4)
}
// pop stack to register pair
func POP_rr(cpu: GameBoyCPU, inout regH: UInt8, inout regL: UInt8) {
    let val = cpu.memory.read16(address: cpu.registers.SP)
    GameBoyRegisters.set16(&regH, &regL, value: val)
    cpu.registers.SP += 2;
    cpu.registers.PC++
    cpu.updateClock(3)
}
// reset (call) to t addr
func RST_t(cpu: GameBoyCPU, t: UInt8) {
    cpu.memory.write16(address: cpu.registers.SP-2, value: cpu.registers.PC+1)
    cpu.registers.SP -= 2;
    cpu.registers.PC = UInt16(t)
    cpu.updateClock(4)
}

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
    let addr = GameBoyRegisters.get16(regH,regL)
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
    GameBoyRegisters.set16(&regH, &regL, value: cpu.memory.read16(address: cpu.registers.PC+1))
    cpu.registers.PC+=3
    cpu.updateClock(3)
}
// load from A to address in register pair
func LD_arr_A(cpu: GameBoyCPU, regH: UInt8, regL: UInt8) {
    let addr = GameBoyRegisters.get16(regH, regL)
    cpu.memory.write(address: addr, value: cpu.registers.A)
    cpu.registers.PC++
    cpu.updateClock(2)
}
// load from 16-bit imediate to stack pointer
func LD_SP_nn(cpu: GameBoyCPU) {
    cpu.registers.SP = cpu.memory.read16(address: cpu.registers.PC+1)
    cpu.registers.PC+=3
    cpu.updateClock(3)
}
// load from address in HL to A and increment HL
func LDI_A_aHL(cpu: GameBoyCPU) {
    var addr = cpu.registers.getHL()
    cpu.registers.A = cpu.memory.read(address: addr)
    ++addr
    cpu.registers.setHL(addr)
    cpu.registers.PC++
    cpu.updateClock(2)
}
// load from address in HL to A and decrement HL
func LDD_A_aHL(cpu: GameBoyCPU) {
    var addr = cpu.registers.getHL()
    cpu.registers.A = cpu.memory.read(address: addr)
    --addr
    cpu.registers.setHL(addr)
    cpu.registers.PC++
    cpu.updateClock(2)
}
// load from A to address in HL and increment HL
func LDI_aHL_A(cpu: GameBoyCPU) {
    var addr = cpu.registers.getHL()
    cpu.memory.write(address: addr, value: cpu.registers.A)
    ++addr
    cpu.registers.setHL(addr)
    cpu.registers.PC++
    cpu.updateClock(2)
}
// load from A to address in HL and decrement HL
func LDD_aHL_A(cpu: GameBoyCPU) {
    var addr = cpu.registers.getHL()
    cpu.memory.write(address: addr, value: cpu.registers.A)
    --addr
    cpu.registers.setHL(addr)
    cpu.registers.PC++
    cpu.updateClock(2)
}
// load from SP to address in 16-bit imediate
func LD_ann_SP(cpu: GameBoyCPU) {
    let addr = cpu.memory.read16(address: cpu.registers.PC+1)
    cpu.memory.write16(address: addr, value: cpu.registers.SP)
    cpu.registers.PC+=3
    cpu.updateClock(5)
}
// load to HL the sum of SP and 8-bit U2 imediate
func LDHL_SP_e(cpu: GameBoyCPU) {
    let tmp = Int8(bitPattern: cpu.memory.read(address: cpu.registers.PC+1))
    let val = UInt16(truncatingBitPattern: Int(cpu.registers.SP) + Int(tmp))
    cpu.registers.setHL(val)
    cpu.registers.F = 0
    if tmp < 0 {
        if cpu.registers.SP & 0x0FFF < UInt16(truncatingBitPattern: Int(-tmp)) { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
        if val > cpu.registers.SP { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    } else {
        if val & 0x0FFF < cpu.registers.SP & 0x0FFF { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
        if val < cpu.registers.SP { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    }
    cpu.registers.PC+=2
    cpu.updateClock(3)
}
// load from HL to SP
func LD_SP_HL(cpu: GameBoyCPU) {
    cpu.registers.SP = cpu.registers.getHL()
    cpu.registers.PC++
    cpu.updateClock(2)
}
// load from A to address in 16-bit imediate
func LD_ann_A(cpu: GameBoyCPU) {
    let addr = cpu.memory.read16(address: cpu.registers.PC+1)
    cpu.memory.write(address: addr, value: cpu.registers.A)
    cpu.registers.PC+=3
    cpu.updateClock(4)
}
// load from A to address 0xFF00 + 8-bit imediate
func LDH_an_A(cpu: GameBoyCPU) {
    let addr = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.memory.write(address: UInt16(addr) + 0xFF00, value: cpu.registers.A)
    cpu.registers.PC+=2
    cpu.updateClock(3)
}
// load from address 0xFF00 + 8-bit imediate to A
func LDH_A_an(cpu: GameBoyCPU) {
    let addr = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.registers.A = cpu.memory.read(address: UInt16(addr) + 0xFF00)
    cpu.registers.PC+=2
    cpu.updateClock(3)
}
// load from A to address 0xFF00 + C
func LDH_aC_A(cpu: GameBoyCPU) {
    cpu.memory.write(address: UInt16(cpu.registers.C) + 0xFF00, value: cpu.registers.A)
    cpu.registers.PC++
    cpu.updateClock(3)
}

// logical
func AND_r(cpu: GameBoyCPU, reg: UInt8) {
    cpu.registers.A &= reg
    cpu.registers.F = cpu.registers.A == 0 ? (GameBoyRegisters.F_ZERO | GameBoyRegisters.F_HALF_CARRY) : GameBoyRegisters.F_HALF_CARRY
    cpu.registers.PC++
    cpu.updateClock(1)
}
func AND_aHL(cpu: GameBoyCPU) {
    let value = cpu.memory.read(address: cpu.registers.getHL())
    cpu.registers.A &= value
    cpu.registers.F = cpu.registers.A == 0 ? (GameBoyRegisters.F_ZERO | GameBoyRegisters.F_HALF_CARRY) : GameBoyRegisters.F_HALF_CARRY
    cpu.registers.PC++
    cpu.updateClock(2)
}
func AND_n(cpu: GameBoyCPU) {
    let value = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.registers.A &= value
    cpu.registers.F = cpu.registers.A == 0 ? (GameBoyRegisters.F_ZERO | GameBoyRegisters.F_HALF_CARRY) : GameBoyRegisters.F_HALF_CARRY
    cpu.registers.PC+=2
    cpu.updateClock(2)
}
func OR_r(cpu: GameBoyCPU, reg: UInt8) {
    cpu.registers.A |= reg
    cpu.registers.F = cpu.registers.A == 0 ? GameBoyRegisters.F_ZERO : 0
    cpu.registers.PC++
    cpu.updateClock(1)
}
func OR_aHL(cpu: GameBoyCPU) {
    let value = cpu.memory.read(address: cpu.registers.getHL())
    cpu.registers.A |= value
    cpu.registers.F = cpu.registers.A == 0 ? GameBoyRegisters.F_ZERO : 0
    cpu.registers.PC++
    cpu.updateClock(2)
}
func OR_n(cpu: GameBoyCPU) {
    let value = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.registers.A |= value
    cpu.registers.F = cpu.registers.A == 0 ? GameBoyRegisters.F_ZERO : 0
    cpu.registers.PC+=2
    cpu.updateClock(2)
}

func XOR_r(cpu: GameBoyCPU, reg: UInt8) {
    cpu.registers.A ^= reg
    cpu.registers.F = cpu.registers.A == 0 ? GameBoyRegisters.F_ZERO : 0
    cpu.registers.PC++
    cpu.updateClock(1)
}
func XOR_aHL(cpu: GameBoyCPU) {
    let value = cpu.memory.read(address: cpu.registers.getHL())
    cpu.registers.A ^= value
    cpu.registers.F = cpu.registers.A == 0 ? GameBoyRegisters.F_ZERO : 0
    cpu.registers.PC++
    cpu.updateClock(2)
}
func XOR_n(cpu: GameBoyCPU) {
    let value = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.registers.A ^= value
    cpu.registers.F = cpu.registers.A == 0 ? GameBoyRegisters.F_ZERO : 0
    cpu.registers.PC+=2
    cpu.updateClock(2)
}

func CP_r(cpu: GameBoyCPU, reg: UInt8) {
    cpu.registers.F = GameBoyRegisters.F_NEGATIVE
    if (cpu.registers.A & 0x0F) < reg { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A < (cpu.registers.A &- reg) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if (cpu.registers.A &- reg) == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.PC++
    cpu.updateClock(1)
}
func CP_aHL(cpu: GameBoyCPU) {
    let value = cpu.memory.read(address: cpu.registers.getHL())
    cpu.registers.F = GameBoyRegisters.F_NEGATIVE
    if (cpu.registers.A & 0x0F) < value { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A < (cpu.registers.A &- value) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if (cpu.registers.A &- value) == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.PC++
    cpu.updateClock(2)
}
func CP_n(cpu: GameBoyCPU) {
    let value = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.registers.F = GameBoyRegisters.F_NEGATIVE
    if (cpu.registers.A & 0x0F) < value { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A < (cpu.registers.A &- value) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if (cpu.registers.A &- value) == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.PC+=2
    cpu.updateClock(2)
}

// negate the acumulator
func CPL(cpu: GameBoyCPU) {
    cpu.registers.A = ~cpu.registers.A
    cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY | GameBoyRegisters.F_NEGATIVE
    cpu.registers.PC++
    cpu.updateClock(1)
}

// incrementation/ decrementation
func INC_r(cpu: GameBoyCPU, inout reg: UInt8) {
    cpu.registers.F &= GameBoyRegisters.F_CARRY // don't change last carry value
    if reg == 0xFF { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if reg & 0x0F == 0x0F { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    reg = reg &+ 1
    cpu.registers.PC++
    cpu.updateClock(1)
}
func DEC_r(cpu: GameBoyCPU, inout reg: UInt8) {
    //flags
    cpu.registers.F &= GameBoyRegisters.F_CARRY
    cpu.registers.F |= GameBoyRegisters.F_NEGATIVE
    if reg == 0x01 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if reg & 0x0F == 0 { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    reg = reg &- 1
    cpu.registers.PC++
    cpu.updateClock(1)
}
func INC_rr(cpu: GameBoyCPU, inout regH: UInt8, inout regL: UInt8) {
    var value = GameBoyRegisters.get16(regH, regL)
    value = value &+ 1
    GameBoyRegisters.set16(&regH, &regL, value: value)
    cpu.registers.PC++
    cpu.updateClock(2)
}
func DEC_rr(cpu: GameBoyCPU, inout regH: UInt8, inout regL: UInt8) {
    var value = GameBoyRegisters.get16(regH, regL)
    value = value &- 1
    GameBoyRegisters.set16(&regH, &regL, value: value)
    cpu.registers.PC++
    cpu.updateClock(2)
}
func INC_SP(cpu: GameBoyCPU) {
    cpu.registers.SP = cpu.registers.SP &+ 1
    cpu.registers.PC++
    cpu.updateClock(2)
}
func DEC_SP(cpu: GameBoyCPU) {
    cpu.registers.SP = cpu.registers.SP &- 1
    cpu.registers.PC++
    cpu.updateClock(2)
}
func INC_aHL(cpu: GameBoyCPU) {
    var val = cpu.memory.read(address: cpu.registers.getHL())
    cpu.registers.F &= GameBoyRegisters.F_CARRY // don't change last carry value
    if val == 0xFF { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if val & 0x0F == 0x0F { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    val = val &+ 1
    cpu.memory.write(address: cpu.registers.getHL(), value: val)
    cpu.registers.PC++
    cpu.updateClock(3)
}
func DEC_aHL(cpu: GameBoyCPU) {
    var val = cpu.memory.read(address: cpu.registers.getHL())
    cpu.registers.F &= GameBoyRegisters.F_CARRY
    cpu.registers.F |= GameBoyRegisters.F_NEGATIVE
    if val == 0x01 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if val & 0x0F == 0 { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    val = val &- 1
    cpu.memory.write(address: cpu.registers.getHL(), value: val)
    cpu.registers.PC++
    cpu.updateClock(3)
}

// arithmetic
func ADD_A_r(cpu: GameBoyCPU, reg: UInt8) {
    cpu.registers.F = 0
    if cpu.registers.A & 0x0F + reg & 0x0F > 0x0F { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A > cpu.registers.A &+ reg { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if cpu.registers.A &+ reg == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.A = cpu.registers.A &+ reg
    cpu.registers.PC++
    cpu.updateClock(1)
}
func ADD_A_aHL(cpu: GameBoyCPU) {
    let val = cpu.memory.read(address: cpu.registers.getHL())
    cpu.registers.F = 0
    if cpu.registers.A & 0x0F + val & 0x0F > 0x0F { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A > cpu.registers.A &+ val { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if cpu.registers.A &+ val == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.A = cpu.registers.A &+ val
    cpu.registers.PC++
    cpu.updateClock(2)
}
func ADD_A_n(cpu: GameBoyCPU) {
    let val = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.registers.F = 0
    if cpu.registers.A & 0x0F + val & 0x0F > 0x0F { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A > cpu.registers.A &+ val { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if cpu.registers.A &+ val == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.A = cpu.registers.A &+ val
    cpu.registers.PC+=2
    cpu.updateClock(2)
}
func ADD_HL_rr(cpu: GameBoyCPU, regH: UInt8, regL: UInt8) {
    let val = GameBoyRegisters.get16(regH, regL)
    cpu.registers.F = cpu.registers.F & GameBoyRegisters.F_ZERO // don't change zero flag
    if cpu.registers.getHL() & 0x0FFF + val & 0x0FFF > 0x0FFF { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.getHL() > cpu.registers.getHL() &+ val { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.registers.setHL(cpu.registers.getHL() &+ val)
    cpu.registers.PC++
    cpu.updateClock(2)
}
func SUB_A_r(cpu: GameBoyCPU, reg: UInt8) {
    cpu.registers.F = GameBoyRegisters.F_NEGATIVE
    if cpu.registers.A & 0x0F < reg { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A < cpu.registers.A &- reg { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if cpu.registers.A &- reg == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.A = cpu.registers.A &- reg
    cpu.registers.PC++
    cpu.updateClock(1)
}
func SUB_A_n(cpu: GameBoyCPU) {
    let val = cpu.memory.read(address: cpu.registers.PC+1)
    cpu.registers.F = GameBoyRegisters.F_NEGATIVE
    if cpu.registers.A & 0x0F < val { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A < cpu.registers.A &- val { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if cpu.registers.A &- val == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.A = cpu.registers.A &- val
    cpu.registers.PC+=2
    cpu.updateClock(2)
}
func SUB_A_aHL(cpu: GameBoyCPU) {
    let val = cpu.memory.read(address: cpu.registers.getHL())
    cpu.registers.F = GameBoyRegisters.F_NEGATIVE
    if cpu.registers.A & 0x0F < val { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A < cpu.registers.A &- val { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if cpu.registers.A &- val == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.A = cpu.registers.A &- val
    cpu.registers.PC++
    cpu.updateClock(2)
}

func ADC_A_r(cpu: GameBoyCPU, reg: UInt8) {
    let val = reg &+ ((cpu.registers.F >> 4) & 0x01)
    cpu.registers.F = 0
    if cpu.registers.A & 0x0F + val & 0x0F > 0x0F { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A > cpu.registers.A &+ val { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if cpu.registers.A &+ val == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.A = cpu.registers.A &+ val
    cpu.registers.PC++
    cpu.updateClock(1)
}
func ADC_A_aHL(cpu: GameBoyCPU) {
    let val = cpu.memory.read(address: cpu.registers.getHL()) &+ ((cpu.registers.F >> 4) & 0x01)
    cpu.registers.F = 0
    if cpu.registers.A & 0x0F + val & 0x0F > 0x0F { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A > cpu.registers.A &+ val { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if cpu.registers.A &+ val == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.A = cpu.registers.A &+ val
    cpu.registers.PC++
    cpu.updateClock(2)
}
func ADC_A_n(cpu: GameBoyCPU) {
    let val = cpu.memory.read(address: cpu.registers.PC+1) &+ ((cpu.registers.F >> 4) & 0x01)
    cpu.registers.F = 0
    if cpu.registers.A & 0x0F + val & 0x0F > 0x0F { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A > cpu.registers.A &+ val { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if cpu.registers.A &+ val == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.A = cpu.registers.A &+ val
    cpu.registers.PC++
    cpu.updateClock(2)
}
func SBC_A_r(cpu: GameBoyCPU, reg: UInt8) {
    let val = reg &+ ((cpu.registers.F >> 4) & 0x01)
    cpu.registers.F = GameBoyRegisters.F_NEGATIVE
    if cpu.registers.A & 0x0F < val { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A < cpu.registers.A &- val { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if cpu.registers.A &- val == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.A = cpu.registers.A &- val
    cpu.registers.PC++
    cpu.updateClock(1)
}
func SBC_A_n(cpu: GameBoyCPU) {
    let val = cpu.memory.read(address: cpu.registers.PC+1) &+ ((cpu.registers.F >> 4) & 0x01)
    cpu.registers.F = GameBoyRegisters.F_NEGATIVE
    if cpu.registers.A & 0x0F < val { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A < cpu.registers.A &- val { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if cpu.registers.A &- val == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.A = cpu.registers.A &- val
    cpu.registers.PC+=2
    cpu.updateClock(2)
}
func SBC_A_aHL(cpu: GameBoyCPU) {
    let val = cpu.memory.read(address: cpu.registers.getHL()) &+ ((cpu.registers.F >> 4) & 0x01)
    cpu.registers.F = GameBoyRegisters.F_NEGATIVE
    if cpu.registers.A & 0x0F < val { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
    if cpu.registers.A < cpu.registers.A &- val { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    if cpu.registers.A &- val == 0 { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.registers.A = cpu.registers.A &- val
    cpu.registers.PC++
    cpu.updateClock(2)
}

func ADD_SP_e(cpu: GameBoyCPU) {
    let tmp = Int8(bitPattern: cpu.memory.read(address: cpu.registers.PC+1))
    let val = UInt16(truncatingBitPattern: Int(cpu.registers.SP) + Int(tmp))
    cpu.registers.F = 0
    if tmp < 0 {
        if cpu.registers.SP & 0x0FFF < UInt16(truncatingBitPattern: Int(-tmp)) { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
        if val > cpu.registers.SP { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    } else {
        if val & 0x0FFF < cpu.registers.SP & 0x0FFF { cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY }
        if val < cpu.registers.SP { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    }
    cpu.registers.SP = val
    cpu.registers.PC+=2
    cpu.updateClock(4)
}
// decimal arithmetic adjust
func DAA(cpu: GameBoyCPU) {
    cpu.registers.F &= GameBoyRegisters.F_NEGATIVE
    if(cpu.registers.A == 0) {
        cpu.registers.F |= GameBoyRegisters.F_ZERO
        cpu.registers.PC++
        cpu.updateClock(1)
        return
    }
    
    if cpu.registers.F & GameBoyRegisters.F_NEGATIVE == 0 {
        //addition
        switch cpu.registers.F & (GameBoyRegisters.F_CARRY | GameBoyRegisters.F_HALF_CARRY) {
        case 0 where cpu.registers.A & 0x0F >= 0x0A && cpu.registers.A & 0xF0 < 0x90:
            cpu.registers.A = cpu.registers.A &+ 0x06
        case 0 where cpu.registers.A & 0x0F < 0x0A && cpu.registers.A & 0xF0 >= 0xA0:
            cpu.registers.A = cpu.registers.A &+ 0x60
            cpu.registers.F |= GameBoyRegisters.F_CARRY
        case 0 where cpu.registers.A & 0x0F >= 0x0A && cpu.registers.A & 0xF0 >= 0x90:
            cpu.registers.A = cpu.registers.A &+ 0x66
            cpu.registers.F |= GameBoyRegisters.F_CARRY
        case GameBoyRegisters.F_HALF_CARRY where cpu.registers.A & 0xF0 < 0xA0:
            cpu.registers.A = cpu.registers.A &+ 0x06
        case GameBoyRegisters.F_HALF_CARRY where cpu.registers.A & 0xF0 >= 0xA0:
            cpu.registers.A = cpu.registers.A &+ 0x66
            cpu.registers.F |= GameBoyRegisters.F_CARRY
        case GameBoyRegisters.F_CARRY where cpu.registers.A & 0x0F < 0x0A:
            cpu.registers.A = cpu.registers.A &+ 0x60
            cpu.registers.F |= GameBoyRegisters.F_CARRY
        case GameBoyRegisters.F_CARRY where cpu.registers.A & 0x0F >= 0x0A:
            cpu.registers.A = cpu.registers.A &+ 0x66
            cpu.registers.F |= GameBoyRegisters.F_CARRY
        case GameBoyRegisters.F_CARRY | GameBoyRegisters.F_HALF_CARRY:
            cpu.registers.A = cpu.registers.A &+ 0x66
            cpu.registers.F |= GameBoyRegisters.F_CARRY
        default:
            break
        }
    } else {
        //subtraction
        switch cpu.registers.F & (GameBoyRegisters.F_CARRY | GameBoyRegisters.F_HALF_CARRY) {
        case GameBoyRegisters.F_HALF_CARRY:
            cpu.registers.A = cpu.registers.A &+ 0xFA
        case GameBoyRegisters.F_CARRY:
            cpu.registers.A = cpu.registers.A &+ 0xA0
            cpu.registers.F |= GameBoyRegisters.F_CARRY
        case GameBoyRegisters.F_CARRY | GameBoyRegisters.F_HALF_CARRY:
            cpu.registers.A = cpu.registers.A &+ 0x9A
            cpu.registers.F |= GameBoyRegisters.F_CARRY
        default:
            break
        }
    }
    cpu.registers.PC++
    cpu.updateClock(1)
}

// jumps
func JP_nn(cpu: GameBoyCPU) {
    cpu.registers.PC = cpu.memory.read16(address: cpu.registers.PC+1)
    cpu.updateClock(4)
}
func JP_cc_nn(cpu: GameBoyCPU, condition: Bool) {
    if condition {
        JP_nn(cpu)
    } else {
        cpu.registers.PC += 3
        cpu.updateClock(3)
    }
}
func JP_aHL(cpu: GameBoyCPU) {
    cpu.registers.PC = cpu.registers.getHL()
    cpu.updateClock(1)
}
func JR_e(cpu: GameBoyCPU) {
    let tmp = cpu.memory.read(address: cpu.registers.PC+1)
    let val = Int(Int8(bitPattern: tmp))
    cpu.registers.PC = UInt16(truncatingBitPattern: Int(cpu.registers.PC) + val)
    cpu.registers.PC+=2
    cpu.updateClock(3)
}
func JR_cc_e(cpu: GameBoyCPU, condition: Bool) {
    if condition {
        JR_e(cpu)
    } else {
        cpu.registers.PC += 2
        cpu.updateClock(2)
    }
}

// calls
func CALL_nn(cpu: GameBoyCPU) {
    let jump = cpu.memory.read16(address: cpu.registers.PC+1)
    cpu.memory.write16(address: cpu.registers.SP-2, value: cpu.registers.PC+3)
    cpu.registers.PC = jump
    cpu.registers.SP -= 2;
    cpu.updateClock(6)
}
func CALL_cc_nn(cpu: GameBoyCPU, condition: Bool) {
    if condition {
        CALL_nn(cpu)
    } else {
        cpu.registers.PC += 3
        cpu.updateClock(3)
    }
}
func RET(cpu: GameBoyCPU) {
    cpu.registers.PC = cpu.memory.read16(address: cpu.registers.SP)
    cpu.registers.SP += 2
    cpu.updateClock(4)
}
func RETI(cpu: GameBoyCPU) {
    cpu.interruptMasterFlag = true
    RET(cpu)
}
func RET_cc(cpu: GameBoyCPU, condition: Bool) {
    if condition {
        RET(cpu)
        cpu.updateClock(1)
    } else {
        cpu.registers.PC++
        cpu.updateClock(2)
    }
}


// 16 bit opcodes
func EXT_OPCODE(cpu: GameBoyCPU) {
    let extOpCodeVal = cpu.memory.read(address: cpu.registers.PC+1)
    let extOpCode = cpu.extOpcodes[Int(extOpCodeVal)]
    
    if extOpCode.instruction != nil {
        //LogD("Called: \"" + extOpCode.name + "\" of code: 0x" + String(format:"%02X", extOpCodeVal) + ". PC= 0x" + String(format:"%04X",cpu.registers.PC+1))
        extOpCode.instruction!(cpu: cpu)
    } else {
        LogE("ERROR: Unimplemented instruction \"" + extOpCode.name + "\" of code: 0x" + String(format:"%02X", extOpCodeVal) + ".")
        exit(-1)
    }
}
