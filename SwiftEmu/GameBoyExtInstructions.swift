//
//  GameBoyExtInstructions.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 19.09.2015.
//  Copyright © 2015 Michal Majczak. All rights reserved.
//

import Foundation

func generateExtOpCodeTable() -> [OpCode] {
    let table = [
        //0x0n
        OpCode("RLC B",nil),
        OpCode("RLC C",nil),
        OpCode("RLC D",nil),
        OpCode("RLC E",nil),
        OpCode("RLC H",nil),
        OpCode("RLC L",nil),
        OpCode("RLC (HL)",nil),
        OpCode("RLC A",nil),
        OpCode("RRC B",nil),
        OpCode("RRC C",nil),
        OpCode("RRC D",nil),
        OpCode("RRC E",nil),
        OpCode("RRC H",nil),
        OpCode("RRC L",nil),
        OpCode("RRC (HL)",nil),
        OpCode("RRC A",nil),
        //0x1n
        OpCode("RL B",nil),
        OpCode("RL C",nil),
        OpCode("RL D",nil),
        OpCode("RL E",nil),
        OpCode("RL H",nil),
        OpCode("RL L",nil),
        OpCode("RL (HL)",nil),
        OpCode("RL A",nil),
        OpCode("RR B",nil),
        OpCode("RR C",nil),
        OpCode("RR D",nil),
        OpCode("RR E",nil),
        OpCode("RR H",nil),
        OpCode("RR L",nil),
        OpCode("RR (HL)",nil),
        OpCode("RR A",nil),
        //0x2n
        OpCode("SLA B",nil),
        OpCode("SLA C",nil),
        OpCode("SLA D",nil),
        OpCode("SLA E",nil),
        OpCode("SLA H",nil),
        OpCode("SLA L",nil),
        OpCode("SLA (HL)",nil),
        OpCode("SLA A",nil),
        OpCode("SRA B",nil),
        OpCode("SRA C",nil),
        OpCode("SRA D",nil),
        OpCode("SRA E",nil),
        OpCode("SRA H",nil),
        OpCode("SRA L",nil),
        OpCode("SRA (HL)",nil),
        OpCode("SRA A",nil),
        //0x3n
        OpCode("SWAP B",nil),
        OpCode("SWAP C",nil),
        OpCode("SWAP D",nil),
        OpCode("SWAP E",nil),
        OpCode("SWAP H",nil),
        OpCode("SWAP L",nil),
        OpCode("SWAP (HL)",nil),
        OpCode("SWAP A",nil),
        OpCode("SRL B",nil),
        OpCode("SRL C",nil),
        OpCode("SRL D",nil),
        OpCode("SRL E",nil),
        OpCode("SRL H",nil),
        OpCode("SRL L",nil),
        OpCode("SRL (HL)",nil),
        OpCode("SRL A",nil),
        //0x4n
        OpCode("BIT 0,B",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 0, reg: cpu.registers.B)}),
        OpCode("BIT 0,C",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 0, reg: cpu.registers.C)}),
        OpCode("BIT 0,D",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 0, reg: cpu.registers.D)}),
        OpCode("BIT 0,E",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 0, reg: cpu.registers.E)}),
        OpCode("BIT 0,H",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 0, reg: cpu.registers.H)}),
        OpCode("BIT 0,L",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 0, reg: cpu.registers.L)}),
        OpCode("BIT 0,(HL)",{(cpu: GameBoyCPU) in BIT_b_aHL(cpu, bit: 0)}),
        OpCode("BIT 0,A",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 0, reg: cpu.registers.A)}),
        OpCode("BIT 1,B",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 1, reg: cpu.registers.B)}),
        OpCode("BIT 1,C",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 1, reg: cpu.registers.C)}),
        OpCode("BIT 1,D",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 1, reg: cpu.registers.D)}),
        OpCode("BIT 1,E",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 1, reg: cpu.registers.E)}),
        OpCode("BIT 1,H",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 1, reg: cpu.registers.H)}),
        OpCode("BIT 1,L",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 1, reg: cpu.registers.L)}),
        OpCode("BIT 1,(HL)",{(cpu: GameBoyCPU) in BIT_b_aHL(cpu, bit: 1)}),
        OpCode("BIT 1,A",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 1, reg: cpu.registers.A)}),
        //0x5n
        OpCode("BIT 2,B",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 2, reg: cpu.registers.B)}),
        OpCode("BIT 2,C",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 2, reg: cpu.registers.C)}),
        OpCode("BIT 2,D",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 2, reg: cpu.registers.D)}),
        OpCode("BIT 2,E",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 2, reg: cpu.registers.E)}),
        OpCode("BIT 2,H",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 2, reg: cpu.registers.H)}),
        OpCode("BIT 2,L",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 2, reg: cpu.registers.L)}),
        OpCode("BIT 2,(HL)",{(cpu: GameBoyCPU) in BIT_b_aHL(cpu, bit: 2)}),
        OpCode("BIT 2,A",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 2, reg: cpu.registers.A)}),
        OpCode("BIT 3,B",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 3, reg: cpu.registers.B)}),
        OpCode("BIT 3,C",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 3, reg: cpu.registers.C)}),
        OpCode("BIT 3,D",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 3, reg: cpu.registers.D)}),
        OpCode("BIT 3,E",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 3, reg: cpu.registers.E)}),
        OpCode("BIT 3,H",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 3, reg: cpu.registers.H)}),
        OpCode("BIT 3,L",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 3, reg: cpu.registers.L)}),
        OpCode("BIT 3,(HL)",{(cpu: GameBoyCPU) in BIT_b_aHL(cpu, bit: 3)}),
        OpCode("BIT 3,A",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 3, reg: cpu.registers.A)}),
        //0x6n
        OpCode("BIT 4,B",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 4, reg: cpu.registers.B)}),
        OpCode("BIT 4,C",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 4, reg: cpu.registers.C)}),
        OpCode("BIT 4,D",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 4, reg: cpu.registers.D)}),
        OpCode("BIT 4,E",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 4, reg: cpu.registers.E)}),
        OpCode("BIT 4,H",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 4, reg: cpu.registers.H)}),
        OpCode("BIT 4,L",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 4, reg: cpu.registers.L)}),
        OpCode("BIT 4,(HL)",{(cpu: GameBoyCPU) in BIT_b_aHL(cpu, bit: 4)}),
        OpCode("BIT 4,A",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 4, reg: cpu.registers.A)}),
        OpCode("BIT 5,B",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 5, reg: cpu.registers.B)}),
        OpCode("BIT 5,C",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 5, reg: cpu.registers.C)}),
        OpCode("BIT 5,D",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 5, reg: cpu.registers.D)}),
        OpCode("BIT 5,E",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 5, reg: cpu.registers.E)}),
        OpCode("BIT 5,H",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 5, reg: cpu.registers.H)}),
        OpCode("BIT 5,L",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 5, reg: cpu.registers.L)}),
        OpCode("BIT 5,(HL)",{(cpu: GameBoyCPU) in BIT_b_aHL(cpu, bit: 5)}),
        OpCode("BIT 5,A",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 5, reg: cpu.registers.A)}),
        //0x7n
        OpCode("BIT 6,B",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 6, reg: cpu.registers.B)}),
        OpCode("BIT 6,C",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 6, reg: cpu.registers.C)}),
        OpCode("BIT 6,D",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 6, reg: cpu.registers.D)}),
        OpCode("BIT 6,E",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 6, reg: cpu.registers.E)}),
        OpCode("BIT 6,H",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 6, reg: cpu.registers.H)}),
        OpCode("BIT 6,L",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 6, reg: cpu.registers.L)}),
        OpCode("BIT 6,(HL)",{(cpu: GameBoyCPU) in BIT_b_aHL(cpu, bit: 6)}),
        OpCode("BIT 6,A",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 6, reg: cpu.registers.A)}),
        OpCode("BIT 7,B",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 7, reg: cpu.registers.B)}),
        OpCode("BIT 7,C",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 7, reg: cpu.registers.C)}),
        OpCode("BIT 7,D",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 7, reg: cpu.registers.D)}),
        OpCode("BIT 7,E",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 7, reg: cpu.registers.E)}),
        OpCode("BIT 7,H",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 7, reg: cpu.registers.H)}),
        OpCode("BIT 7,L",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 7, reg: cpu.registers.L)}),
        OpCode("BIT 7,(HL)",{(cpu: GameBoyCPU) in BIT_b_aHL(cpu, bit: 7)}),
        OpCode("BIT 7,A",{(cpu: GameBoyCPU) in BIT_b_r(cpu, bit: 7, reg: cpu.registers.A)}),
        //0x8n
        OpCode("RES 0,B",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 0, reg: &cpu.registers.B)}),
        OpCode("RES 0,C",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 0, reg: &cpu.registers.C)}),
        OpCode("RES 0,D",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 0, reg: &cpu.registers.D)}),
        OpCode("RES 0,E",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 0, reg: &cpu.registers.E)}),
        OpCode("RES 0,H",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 0, reg: &cpu.registers.H)}),
        OpCode("RES 0,L",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 0, reg: &cpu.registers.L)}),
        OpCode("RES 0,(HL)",{(cpu: GameBoyCPU) in RES_b_aHL(cpu, bit: 0)}),
        OpCode("RES 0,A",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 0, reg: &cpu.registers.A)}),
        OpCode("RES 1,B",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 1, reg: &cpu.registers.B)}),
        OpCode("RES 1,C",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 1, reg: &cpu.registers.C)}),
        OpCode("RES 1,D",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 1, reg: &cpu.registers.D)}),
        OpCode("RES 1,E",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 1, reg: &cpu.registers.E)}),
        OpCode("RES 1,H",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 1, reg: &cpu.registers.H)}),
        OpCode("RES 1,L",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 1, reg: &cpu.registers.L)}),
        OpCode("RES 1,(HL)",{(cpu: GameBoyCPU) in RES_b_aHL(cpu, bit: 1)}),
        OpCode("RES 1,A",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 1, reg: &cpu.registers.A)}),
        //0x9n
        OpCode("RES 2,B",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 2, reg: &cpu.registers.B)}),
        OpCode("RES 2,C",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 2, reg: &cpu.registers.C)}),
        OpCode("RES 2,D",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 2, reg: &cpu.registers.D)}),
        OpCode("RES 2,E",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 2, reg: &cpu.registers.E)}),
        OpCode("RES 2,H",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 2, reg: &cpu.registers.H)}),
        OpCode("RES 2,L",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 2, reg: &cpu.registers.L)}),
        OpCode("RES 2,(HL)",{(cpu: GameBoyCPU) in RES_b_aHL(cpu, bit: 2)}),
        OpCode("RES 2,A",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 2, reg: &cpu.registers.A)}),
        OpCode("RES 3,B",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 3, reg: &cpu.registers.B)}),
        OpCode("RES 3,C",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 3, reg: &cpu.registers.C)}),
        OpCode("RES 3,D",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 3, reg: &cpu.registers.D)}),
        OpCode("RES 3,E",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 3, reg: &cpu.registers.E)}),
        OpCode("RES 3,H",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 3, reg: &cpu.registers.H)}),
        OpCode("RES 3,L",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 3, reg: &cpu.registers.L)}),
        OpCode("RES 3,(HL)",{(cpu: GameBoyCPU) in RES_b_aHL(cpu, bit: 3)}),
        OpCode("RES 3,A",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 3, reg: &cpu.registers.A)}),
        //0xAn
        OpCode("RES 4,B",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 4, reg: &cpu.registers.B)}),
        OpCode("RES 4,C",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 4, reg: &cpu.registers.C)}),
        OpCode("RES 4,D",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 4, reg: &cpu.registers.D)}),
        OpCode("RES 4,E",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 4, reg: &cpu.registers.E)}),
        OpCode("RES 4,H",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 4, reg: &cpu.registers.H)}),
        OpCode("RES 4,L",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 4, reg: &cpu.registers.L)}),
        OpCode("RES 4,(HL)",{(cpu: GameBoyCPU) in RES_b_aHL(cpu, bit: 4)}),
        OpCode("RES 4,A",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 4, reg: &cpu.registers.A)}),
        OpCode("RES 5,B",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 5, reg: &cpu.registers.B)}),
        OpCode("RES 5,C",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 5, reg: &cpu.registers.C)}),
        OpCode("RES 5,D",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 5, reg: &cpu.registers.D)}),
        OpCode("RES 5,E",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 5, reg: &cpu.registers.E)}),
        OpCode("RES 5,H",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 5, reg: &cpu.registers.H)}),
        OpCode("RES 5,L",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 5, reg: &cpu.registers.L)}),
        OpCode("RES 5,(HL)",{(cpu: GameBoyCPU) in RES_b_aHL(cpu, bit: 5)}),
        OpCode("RES 5,A",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 5, reg: &cpu.registers.A)}),
        //0xBn
        OpCode("RES 6,B",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 6, reg: &cpu.registers.B)}),
        OpCode("RES 6,C",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 6, reg: &cpu.registers.C)}),
        OpCode("RES 6,D",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 6, reg: &cpu.registers.D)}),
        OpCode("RES 6,E",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 6, reg: &cpu.registers.E)}),
        OpCode("RES 6,H",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 6, reg: &cpu.registers.H)}),
        OpCode("RES 6,L",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 6, reg: &cpu.registers.L)}),
        OpCode("RES 6,(HL)",{(cpu: GameBoyCPU) in RES_b_aHL(cpu, bit: 6)}),
        OpCode("RES 6,A",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 6, reg: &cpu.registers.A)}),
        OpCode("RES 7,B",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 7, reg: &cpu.registers.B)}),
        OpCode("RES 7,C",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 7, reg: &cpu.registers.C)}),
        OpCode("RES 7,D",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 7, reg: &cpu.registers.D)}),
        OpCode("RES 7,E",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 7, reg: &cpu.registers.E)}),
        OpCode("RES 7,H",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 7, reg: &cpu.registers.H)}),
        OpCode("RES 7,L",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 7, reg: &cpu.registers.L)}),
        OpCode("RES 7,(HL)",{(cpu: GameBoyCPU) in RES_b_aHL(cpu, bit: 7)}),
        OpCode("RES 7,A",{(cpu: GameBoyCPU) in RES_b_r(cpu, bit: 7, reg: &cpu.registers.A)}),
        //0xCn
        OpCode("SET 0,B",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 0, reg: &cpu.registers.B)}),
        OpCode("SET 0,C",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 0, reg: &cpu.registers.C)}),
        OpCode("SET 0,D",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 0, reg: &cpu.registers.D)}),
        OpCode("SET 0,E",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 0, reg: &cpu.registers.E)}),
        OpCode("SET 0,H",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 0, reg: &cpu.registers.H)}),
        OpCode("SET 0,L",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 0, reg: &cpu.registers.L)}),
        OpCode("SET 0,(HL)",{(cpu: GameBoyCPU) in SET_b_aHL(cpu, bit: 0)}),
        OpCode("SET 0,A",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 0, reg: &cpu.registers.A)}),
        OpCode("SET 1,B",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 1, reg: &cpu.registers.B)}),
        OpCode("SET 1,C",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 1, reg: &cpu.registers.C)}),
        OpCode("SET 1,D",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 1, reg: &cpu.registers.D)}),
        OpCode("SET 1,E",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 1, reg: &cpu.registers.E)}),
        OpCode("SET 1,H",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 1, reg: &cpu.registers.H)}),
        OpCode("SET 1,L",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 1, reg: &cpu.registers.L)}),
        OpCode("SET 1,(HL)",{(cpu: GameBoyCPU) in SET_b_aHL(cpu, bit: 1)}),
        OpCode("SET 1,A",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 1, reg: &cpu.registers.A)}),
        //0xDn
        OpCode("SET 2,B",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 2, reg: &cpu.registers.B)}),
        OpCode("SET 2,C",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 2, reg: &cpu.registers.C)}),
        OpCode("SET 2,D",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 2, reg: &cpu.registers.D)}),
        OpCode("SET 2,E",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 2, reg: &cpu.registers.E)}),
        OpCode("SET 2,H",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 2, reg: &cpu.registers.H)}),
        OpCode("SET 2,L",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 2, reg: &cpu.registers.L)}),
        OpCode("SET 2,(HL)",{(cpu: GameBoyCPU) in SET_b_aHL(cpu, bit: 2)}),
        OpCode("SET 2,A",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 2, reg: &cpu.registers.A)}),
        OpCode("SET 3,B",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 3, reg: &cpu.registers.B)}),
        OpCode("SET 3,C",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 3, reg: &cpu.registers.C)}),
        OpCode("SET 3,D",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 3, reg: &cpu.registers.D)}),
        OpCode("SET 3,E",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 3, reg: &cpu.registers.E)}),
        OpCode("SET 3,H",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 3, reg: &cpu.registers.H)}),
        OpCode("SET 3,L",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 3, reg: &cpu.registers.L)}),
        OpCode("SET 3,(HL)",{(cpu: GameBoyCPU) in SET_b_aHL(cpu, bit: 3)}),
        OpCode("SET 3,A",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 3, reg: &cpu.registers.A)}),
        //0xEn
        OpCode("SET 4,B",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 4, reg: &cpu.registers.B)}),
        OpCode("SET 4,C",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 4, reg: &cpu.registers.C)}),
        OpCode("SET 4,D",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 4, reg: &cpu.registers.D)}),
        OpCode("SET 4,E",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 4, reg: &cpu.registers.E)}),
        OpCode("SET 4,H",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 4, reg: &cpu.registers.H)}),
        OpCode("SET 4,L",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 4, reg: &cpu.registers.L)}),
        OpCode("SET 4,(HL)",{(cpu: GameBoyCPU) in SET_b_aHL(cpu, bit: 4)}),
        OpCode("SET 4,A",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 4, reg: &cpu.registers.A)}),
        OpCode("SET 5,B",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 5, reg: &cpu.registers.B)}),
        OpCode("SET 5,C",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 5, reg: &cpu.registers.C)}),
        OpCode("SET 5,D",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 5, reg: &cpu.registers.D)}),
        OpCode("SET 5,E",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 5, reg: &cpu.registers.E)}),
        OpCode("SET 5,H",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 5, reg: &cpu.registers.H)}),
        OpCode("SET 5,L",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 5, reg: &cpu.registers.L)}),
        OpCode("SET 5,(HL)",{(cpu: GameBoyCPU) in SET_b_aHL(cpu, bit: 5)}),
        OpCode("SET 5,A",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 5, reg: &cpu.registers.A)}),
        //0xFn
        OpCode("SET 6,B",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 6, reg: &cpu.registers.B)}),
        OpCode("SET 6,C",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 6, reg: &cpu.registers.C)}),
        OpCode("SET 6,D",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 6, reg: &cpu.registers.D)}),
        OpCode("SET 6,E",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 6, reg: &cpu.registers.E)}),
        OpCode("SET 6,H",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 6, reg: &cpu.registers.H)}),
        OpCode("SET 6,L",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 6, reg: &cpu.registers.L)}),
        OpCode("SET 6,(HL)",{(cpu: GameBoyCPU) in SET_b_aHL(cpu, bit: 6)}),
        OpCode("SET 6,A",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 6, reg: &cpu.registers.A)}),
        OpCode("SET 7,B",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 7, reg: &cpu.registers.B)}),
        OpCode("SET 7,C",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 7, reg: &cpu.registers.C)}),
        OpCode("SET 7,D",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 7, reg: &cpu.registers.D)}),
        OpCode("SET 7,E",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 7, reg: &cpu.registers.E)}),
        OpCode("SET 7,H",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 7, reg: &cpu.registers.H)}),
        OpCode("SET 7,L",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 7, reg: &cpu.registers.L)}),
        OpCode("SET 7,(HL)",{(cpu: GameBoyCPU) in SET_b_aHL(cpu, bit: 7)}),
        OpCode("SET 7,A",{(cpu: GameBoyCPU) in SET_b_r(cpu, bit: 7, reg: &cpu.registers.A)})]
    return table
}

// extended instructions

func BIT_b_r(cpu: GameBoyCPU, bit: UInt8, reg: UInt8) {
    let mask = UInt8(0x01 << bit)
    cpu.registers.F = F_HALF_CARRY
    if(mask & reg == 0) { cpu.registers.F |= F_ZERO }
    cpu.updateClock(2)
    cpu.registers.PC+=2
}

func BIT_b_aHL(cpu: GameBoyCPU, bit: UInt8) {
    let mask = UInt8(0x01 << bit)
    let val = cpu.memory.read(address: cpu.registers.getHL())
    cpu.registers.F = F_HALF_CARRY
    if(mask & val == 0) { cpu.registers.F |= F_ZERO }
    cpu.updateClock(3)
    cpu.registers.PC+=2
}

func SET_b_r(cpu: GameBoyCPU, bit: UInt8, inout reg: UInt8) {
    let mask = UInt8(0x01 << bit)
    reg = reg | mask
    cpu.updateClock(2)
    cpu.registers.PC+=2
}

func SET_b_aHL(cpu: GameBoyCPU, bit: UInt8) {
    let mask = UInt8(0x01 << bit)
    var val = cpu.memory.read(address: cpu.registers.getHL())
    val = val | mask
    cpu.memory.write(address: cpu.registers.getHL(), value: val)
    cpu.updateClock(4)
    cpu.registers.PC+=2
}

func RES_b_r(cpu: GameBoyCPU, bit: UInt8, inout reg: UInt8) {
    let mask = UInt8(0x01 << bit)
    reg = reg | ~mask
    cpu.updateClock(2)
    cpu.registers.PC+=2
}

func RES_b_aHL(cpu: GameBoyCPU, bit: UInt8) {
    let mask = UInt8(0x01 << bit)
    var val = cpu.memory.read(address: cpu.registers.getHL())
    val = val | ~mask
    cpu.memory.write(address: cpu.registers.getHL(), value: val)
    cpu.updateClock(4)
    cpu.registers.PC+=2
}