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
        OpCode("RLC B",{(cpu: GameBoyCPU) in RLC_r(cpu, reg: &cpu.registers.B)}),
        OpCode("RLC C",{(cpu: GameBoyCPU) in RLC_r(cpu, reg: &cpu.registers.C)}),
        OpCode("RLC D",{(cpu: GameBoyCPU) in RLC_r(cpu, reg: &cpu.registers.D)}),
        OpCode("RLC E",{(cpu: GameBoyCPU) in RLC_r(cpu, reg: &cpu.registers.E)}),
        OpCode("RLC H",{(cpu: GameBoyCPU) in RLC_r(cpu, reg: &cpu.registers.H)}),
        OpCode("RLC L",{(cpu: GameBoyCPU) in RLC_r(cpu, reg: &cpu.registers.L)}),
        OpCode("RLC (HL)",RLC_aHL),
        OpCode("RLC A",{(cpu: GameBoyCPU) in RLC_r(cpu, reg: &cpu.registers.A)}),
        OpCode("RRC B",{(cpu: GameBoyCPU) in RRC_r(cpu, reg: &cpu.registers.B)}),
        OpCode("RRC C",{(cpu: GameBoyCPU) in RRC_r(cpu, reg: &cpu.registers.C)}),
        OpCode("RRC D",{(cpu: GameBoyCPU) in RRC_r(cpu, reg: &cpu.registers.D)}),
        OpCode("RRC E",{(cpu: GameBoyCPU) in RRC_r(cpu, reg: &cpu.registers.E)}),
        OpCode("RRC H",{(cpu: GameBoyCPU) in RRC_r(cpu, reg: &cpu.registers.H)}),
        OpCode("RRC L",{(cpu: GameBoyCPU) in RRC_r(cpu, reg: &cpu.registers.L)}),
        OpCode("RRC (HL)",RRC_aHL),
        OpCode("RRC A",{(cpu: GameBoyCPU) in RRC_r(cpu, reg: &cpu.registers.A)}),
        //0x1n
        OpCode("RL B",{(cpu: GameBoyCPU) in RL_r(cpu, reg: &cpu.registers.B)}),
        OpCode("RL C",{(cpu: GameBoyCPU) in RL_r(cpu, reg: &cpu.registers.C)}),
        OpCode("RL D",{(cpu: GameBoyCPU) in RL_r(cpu, reg: &cpu.registers.D)}),
        OpCode("RL E",{(cpu: GameBoyCPU) in RL_r(cpu, reg: &cpu.registers.E)}),
        OpCode("RL H",{(cpu: GameBoyCPU) in RL_r(cpu, reg: &cpu.registers.H)}),
        OpCode("RL L",{(cpu: GameBoyCPU) in RL_r(cpu, reg: &cpu.registers.L)}),
        OpCode("RL (HL)",RL_aHL),
        OpCode("RL A",{(cpu: GameBoyCPU) in RL_r(cpu, reg: &cpu.registers.A)}),
        OpCode("RR B",{(cpu: GameBoyCPU) in RR_r(cpu, reg: &cpu.registers.B)}),
        OpCode("RR C",{(cpu: GameBoyCPU) in RR_r(cpu, reg: &cpu.registers.C)}),
        OpCode("RR D",{(cpu: GameBoyCPU) in RR_r(cpu, reg: &cpu.registers.D)}),
        OpCode("RR E",{(cpu: GameBoyCPU) in RR_r(cpu, reg: &cpu.registers.E)}),
        OpCode("RR H",{(cpu: GameBoyCPU) in RR_r(cpu, reg: &cpu.registers.H)}),
        OpCode("RR L",{(cpu: GameBoyCPU) in RR_r(cpu, reg: &cpu.registers.L)}),
        OpCode("RR (HL)",RR_aHL),
        OpCode("RR A",{(cpu: GameBoyCPU) in RR_r(cpu, reg: &cpu.registers.A)}),
        //0x2n
        OpCode("SLA B",{(cpu: GameBoyCPU) in SLA_r(cpu, reg: &cpu.registers.B)}),
        OpCode("SLA C",{(cpu: GameBoyCPU) in SLA_r(cpu, reg: &cpu.registers.C)}),
        OpCode("SLA D",{(cpu: GameBoyCPU) in SLA_r(cpu, reg: &cpu.registers.D)}),
        OpCode("SLA E",{(cpu: GameBoyCPU) in SLA_r(cpu, reg: &cpu.registers.E)}),
        OpCode("SLA H",{(cpu: GameBoyCPU) in SLA_r(cpu, reg: &cpu.registers.H)}),
        OpCode("SLA L",{(cpu: GameBoyCPU) in SLA_r(cpu, reg: &cpu.registers.L)}),
        OpCode("SLA (HL)",SLA_aHL),
        OpCode("SLA A",{(cpu: GameBoyCPU) in SLA_r(cpu, reg: &cpu.registers.A)}),
        OpCode("SRA B",{(cpu: GameBoyCPU) in SRA_r(cpu, reg: &cpu.registers.B)}),
        OpCode("SRA C",{(cpu: GameBoyCPU) in SRA_r(cpu, reg: &cpu.registers.C)}),
        OpCode("SRA D",{(cpu: GameBoyCPU) in SRA_r(cpu, reg: &cpu.registers.D)}),
        OpCode("SRA E",{(cpu: GameBoyCPU) in SRA_r(cpu, reg: &cpu.registers.E)}),
        OpCode("SRA H",{(cpu: GameBoyCPU) in SRA_r(cpu, reg: &cpu.registers.H)}),
        OpCode("SRA L",{(cpu: GameBoyCPU) in SRA_r(cpu, reg: &cpu.registers.L)}),
        OpCode("SRA (HL)",SRA_aHL),
        OpCode("SRA A",{(cpu: GameBoyCPU) in SRA_r(cpu, reg: &cpu.registers.A)}),
        //0x3n
        OpCode("SWAP B",{(cpu: GameBoyCPU) in SWAP_r(cpu, reg: &cpu.registers.B)}),
        OpCode("SWAP C",{(cpu: GameBoyCPU) in SWAP_r(cpu, reg: &cpu.registers.C)}),
        OpCode("SWAP D",{(cpu: GameBoyCPU) in SWAP_r(cpu, reg: &cpu.registers.D)}),
        OpCode("SWAP E",{(cpu: GameBoyCPU) in SWAP_r(cpu, reg: &cpu.registers.E)}),
        OpCode("SWAP H",{(cpu: GameBoyCPU) in SWAP_r(cpu, reg: &cpu.registers.H)}),
        OpCode("SWAP L",{(cpu: GameBoyCPU) in SWAP_r(cpu, reg: &cpu.registers.L)}),
        OpCode("SWAP (HL)",SWAP_aHL),
        OpCode("SWAP A",{(cpu: GameBoyCPU) in SWAP_r(cpu, reg: &cpu.registers.A)}),
        OpCode("SRL B",{(cpu: GameBoyCPU) in SRL_r(cpu, reg: &cpu.registers.B)}),
        OpCode("SRL C",{(cpu: GameBoyCPU) in SRL_r(cpu, reg: &cpu.registers.C)}),
        OpCode("SRL D",{(cpu: GameBoyCPU) in SRL_r(cpu, reg: &cpu.registers.D)}),
        OpCode("SRL E",{(cpu: GameBoyCPU) in SRL_r(cpu, reg: &cpu.registers.E)}),
        OpCode("SRL H",{(cpu: GameBoyCPU) in SRL_r(cpu, reg: &cpu.registers.H)}),
        OpCode("SRL L",{(cpu: GameBoyCPU) in SRL_r(cpu, reg: &cpu.registers.L)}),
        OpCode("SRL (HL)",SRL_aHL),
        OpCode("SRL A",{(cpu: GameBoyCPU) in SRL_r(cpu, reg: &cpu.registers.A)}),
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
// rotate left, push to carry
func RLC_r(cpu: GameBoyCPU, inout reg: UInt8, clock: UInt8 = 2) {
    let carry = (reg & 0x80) >> 7
    reg = (reg << 1) + carry
    cpu.registers.F = 0
    if(reg == 0 && clock == 2) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if(carry > 0) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.updateClock(clock)
    cpu.registers.PC+=2
}
func RLC_aHL(cpu: GameBoyCPU) {
    var val = cpu.memory.read(address: cpu.registers.getHL())
    let carry = (val & 0x80) >> 7
    val = (val << 1) + carry
    cpu.memory.write(address: cpu.registers.getHL(), value: val)
    cpu.registers.F = 0
    if(val == 0) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if(carry > 0) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.updateClock(4)
    cpu.registers.PC+=2
}

// 9-bit rotate left using carry
func RL_r(cpu: GameBoyCPU, inout reg: UInt8, clock: UInt8 = 2) {
    let carry = reg & 0x80
    reg = (reg << 1)
    if cpu.registers.F & GameBoyRegisters.F_CARRY > 0 { reg += 0x01 }
    cpu.registers.F = 0
    if(reg == 0 && clock == 2) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if(carry > 0) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.updateClock(clock)
    cpu.registers.PC+=2
}
func RL_aHL(cpu: GameBoyCPU) {
    var val = cpu.memory.read(address: cpu.registers.getHL())
    let carry = val & 0x80
    val = (val << 1)
    if cpu.registers.F & GameBoyRegisters.F_CARRY > 0 { val += 0x01 }
    cpu.memory.write(address: cpu.registers.getHL(), value: val)
    cpu.registers.F = 0
    if(val == 0) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if(carry > 0) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.updateClock(4)
    cpu.registers.PC+=2
}

// rotate right, push to carry
func RRC_r(cpu: GameBoyCPU, inout reg: UInt8, clock: UInt8 = 2) {
    let carry = (reg & 0x01) << 7
    reg = (reg >> 1) + carry
    cpu.registers.F = 0
    if(reg == 0 && clock == 2) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if(carry > 0) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.updateClock(clock)
    cpu.registers.PC+=2
}
func RRC_aHL(cpu: GameBoyCPU) {
    var val = cpu.memory.read(address: cpu.registers.getHL())
    let carry = (val & 0x01) << 7
    val = (val >> 1) + carry
    cpu.memory.write(address: cpu.registers.getHL(), value: val)
    cpu.registers.F = 0
    if(val == 0) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if(carry > 0) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.updateClock(4)
    cpu.registers.PC+=2
}

// 9-bit rotate right using carry
func RR_r(cpu: GameBoyCPU, inout reg: UInt8, clock: UInt8 = 2) {
    let carry = reg & 0x01
    reg = (reg >> 1)
    if cpu.registers.F & GameBoyRegisters.F_CARRY > 0 { reg += 0x80 }
    cpu.registers.F = 0
    if(reg == 0 && clock == 2) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if(carry > 0) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.updateClock(clock)
    cpu.registers.PC+=2
}
func RR_aHL(cpu: GameBoyCPU) {
    var val = cpu.memory.read(address: cpu.registers.getHL())
    let carry = val & 0x01
    val = (val >> 1)
    if cpu.registers.F & GameBoyRegisters.F_CARRY > 0 { val += 0x80 }
    cpu.memory.write(address: cpu.registers.getHL(), value: val)
    cpu.registers.F = 0
    if(val == 0) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if(carry > 0) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.updateClock(4)
    cpu.registers.PC+=2
}

// shift left, push 0
func SLA_r(cpu: GameBoyCPU, inout reg: UInt8) {
    let carry = reg & 0x80
    reg = (reg << 1)
    cpu.registers.F = 0
    if(reg == 0) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if(carry > 0) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.updateClock(2)
    cpu.registers.PC+=2
}
func SLA_aHL(cpu: GameBoyCPU) {
    var val = cpu.memory.read(address: cpu.registers.getHL())
    let carry = val & 0x80
    val = (val << 1)
    cpu.memory.write(address: cpu.registers.getHL(), value: val)
    cpu.registers.F = 0
    if(val == 0) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if(carry > 0) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.updateClock(4)
    cpu.registers.PC+=2
}

// shift right, push sign
func SRA_r(cpu: GameBoyCPU, inout reg: UInt8) {
    let carry = reg & 0x01
    reg = (reg >> 1) + (reg & 0x80)
    cpu.registers.F = 0
    if(reg == 0) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if(carry > 0) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.updateClock(2)
    cpu.registers.PC+=2
}
func SRA_aHL(cpu: GameBoyCPU) {
    var val = cpu.memory.read(address: cpu.registers.getHL())
    let carry = val & 0x01
    val = (val >> 1)  + (val & 0x80)
    cpu.memory.write(address: cpu.registers.getHL(), value: val)
    cpu.registers.F = 0
    if(val == 0) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if(carry > 0) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.updateClock(4)
    cpu.registers.PC+=2
}

// shif right, push 0
func SRL_r(cpu: GameBoyCPU, inout reg: UInt8) {
    let carry = reg & 0x01
    reg = (reg >> 1)
    cpu.registers.F = 0
    if(reg == 0) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if(carry > 0) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.updateClock(2)
    cpu.registers.PC+=2
}
func SRL_aHL(cpu: GameBoyCPU) {
    var val = cpu.memory.read(address: cpu.registers.getHL())
    let carry = val & 0x01
    val = (val >> 1)
    cpu.memory.write(address: cpu.registers.getHL(), value: val)
    cpu.registers.F = 0
    if(val == 0) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    if(carry > 0) { cpu.registers.F |= GameBoyRegisters.F_CARRY }
    cpu.updateClock(4)
    cpu.registers.PC+=2
}

// swap higher and lower nybbles
func SWAP_r(cpu: GameBoyCPU, inout reg: UInt8) {
    reg = (reg << 4) + (reg >> 4)
    cpu.registers.F = 0
    if(reg == 0) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.updateClock(2)
    cpu.registers.PC+=2
}
func SWAP_aHL(cpu: GameBoyCPU) {
    var val = cpu.memory.read(address: cpu.registers.getHL())
    val = (val << 4) + (val >> 4)
    cpu.memory.write(address: cpu.registers.getHL(), value: val)
    cpu.registers.F = 0
    if(val == 0) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.updateClock(4)
    cpu.registers.PC+=2
}

// check bit of given number
func BIT_b_r(cpu: GameBoyCPU, bit: UInt8, reg: UInt8) {
    let mask = UInt8(0x01 << bit)
    cpu.registers.F &= GameBoyRegisters.F_CARRY
    cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY
    if(mask & reg == 0) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.updateClock(2)
    cpu.registers.PC+=2
}
func BIT_b_aHL(cpu: GameBoyCPU, bit: UInt8) {
    let mask = UInt8(0x01 << bit)
    let val = cpu.memory.read(address: cpu.registers.getHL())
    cpu.registers.F &= GameBoyRegisters.F_CARRY
    cpu.registers.F |= GameBoyRegisters.F_HALF_CARRY
    if(mask & val == 0) { cpu.registers.F |= GameBoyRegisters.F_ZERO }
    cpu.updateClock(3)
    cpu.registers.PC+=2
}

// set bit of given number
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

// reset bit of given number
func RES_b_r(cpu: GameBoyCPU, bit: UInt8, inout reg: UInt8) {
    let mask = UInt8(0x01 << bit)
    reg = reg & ~mask
    cpu.updateClock(2)
    cpu.registers.PC+=2
}
func RES_b_aHL(cpu: GameBoyCPU, bit: UInt8) {
    let mask = UInt8(0x01 << bit)
    var val = cpu.memory.read(address: cpu.registers.getHL())
    val = val & ~mask
    cpu.memory.write(address: cpu.registers.getHL(), value: val)
    cpu.updateClock(4)
    cpu.registers.PC+=2
}