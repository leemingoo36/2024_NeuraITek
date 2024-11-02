import numpy as np
import sys



inst_mem = []
inst_str_mem = []


data_mem = []

result_mem = []

cc = 0

pc = 0
inst_counter = 0 #명령어 실행 수

b_addr = 0
j_addr = 0

#binary 명령어 파일
with open("512_bin.txt", "r")as f:
    for line in f:
        inst_mem.append(line)

#hex 파일
with open("Lena.txt", "r") as f:
    for line in f:
        data_mem.append(line)





# for data in data_mem:
#     v = []
#     for i in range(0, 32, 2):
#         v.append(int(data[i:i+2], 16))
#     data_int_mem.append(v)

#asm 파일
with open("512_inst.txt", "r") as f:
    for line in f:
        inst_str_mem.append(line)

def PC_logic(pc, b_addr, j_addr, b_taken, j_taken):
    if b_taken:
        pc = b_addr
    elif j_taken:
        pc = j_addr
    else:
        pc = pc
    return pc

def Fetch(pc):
    global inst_counter
    inst = inst_mem[pc]
    inst_str = inst_str_mem[pc]
    print(f"{inst_counter}: {inst_str[:-1]}")
    
    inst_counter += 1
    pc = pc
    pc_inc = pc + 1
    return pc, pc_inc, inst

def Decode(pc, inst, sReg, vReg):
    global j_addr
    opcode = inst[27:]
    rD = inst[22:27]
    rA = inst[17:22]
    rB = inst[12:17]
    off = inst[0:12]
    strd = inst[0:3]
    offB = inst[0:17]
    offBA = inst[0:22]
    offBAD = inst[0:27]
    offD = off + rD

    iopcode = int(opcode, 2)
    irD = int(rD, 2)
    irA = int(rA, 2)
    irB = int(rB, 2)
    ioff = int(off, 2)
    istrd = int(strd, 2)
    ioffB = int(offB, 2)
    ioffBA = int(offBA, 2)
    ioffBAD = int(offBAD, 2) if offBAD[0] == '0' else -(2**27 - int(offBAD, 2))
    ioffD = int(offD, 2)

    j_addr = ioffBAD

    ldr = iopcode in [1, 2]
    ldri = iopcode == 3
    strv = iopcode == 4
    jmp = iopcode == 9
    b = 1 if iopcode == 6 else (2 if iopcode == 7 else (3 if iopcode == 8 else 0))
    wb = 1 if iopcode in [2, 3, 12, 15, 18] else (2 if iopcode in [1, 10, 11, 13, 14, 17, 20] else 0)
    unary = 1 if iopcode in [3, 5, 20] else 0
    alu = 1 if iopcode == 11 else (2 if iopcode in [1, 2, 4, 5, 6, 7, 8, 12] else (3 if iopcode == 14 else (4 if iopcode in [15, 19] else (5 if iopcode == 17 else (6 if iopcode == 18 else (7 if iopcode == 20 else (8 if iopcode == 10 else (9 if iopcode == 13 else (10 if iopcode == 16 else 0)))))))))
    setcc = iopcode == 19
    mem_rw = 1 if iopcode in [4, 5] else 0
    mem_v = 1 if iopcode in [1, 4] else 0
    conv_en = iopcode == 16

    sA = ioffBA if ldri else (pc if b != 0 else (sReg[irA]))
    sB = ioffB if ldr else (ioffBAD if b != 0 else (0 if unary else (ioffD if strv else sReg[irB])))

    vA = 0 if unary else vReg[irA]
    vB = 0 if unary else vReg[irB]

    #16 outputs
    return pc, sA, sB, vA, vB, irD, istrd, ldr, jmp, b, wb, alu, setcc, mem_rw, mem_v, conv_en

def Execute(pc, sA, sB, vA, vB, irD, istrd, ldr, b, wb, alu, setcc, mem_rw, mem_v, conv_en, b_addr, conv_result):
    global cc, b_taken

    conv_result = conv_result
    conv_out = []
    conv_addr = 0
    conv_write = 0
    if len(conv_result) == 16:
        conv_result = []
        conv_out = []

    s_write = sB
    v_write = vB
    rD = irD
    s_result = 0
    v_result = 0

    ldr = ldr
    wb = wb
    mem_rw = mem_rw
    mem_v = mem_v

    #1: branch, 2: equal, 3: a > b
    b_taken = (b == 1 or ((b == 2) and (cc == 1)) or ((b == 3) and (cc == 2)))
    b_addr = b_addr

    if alu == 1:
        #addvs
        v_result = [x + sB for x in vA]
    elif alu == 2:
        #addss
        s_result = sA + sB
        b_addr = s_result
    elif alu == 3:
        #subvs
        v_result = [x - sB for x in vA]
        v_result = [0 if x < 0 else (255 if x > 255 else x) for x in v_result]    
    elif alu == 4:
        #subss
        s_result = sA - sB
        if setcc:
            cc = 1 if s_result == 0 else (2 if s_result > 0 else 0)
    elif alu == 5:
        #mulvs
        v_result = [x * sB for x in vA]
        v_result = [0 if x < 0 else (255 if x > 255 else x) for x in v_result]
    elif alu == 6:
        #mulss
        s_result = sA * sB
    elif alu == 7:
        #relu
        v_result = [0 if x < 0 else x for x in vA]
    elif alu == 8:
        #addvv
        for i in range(16):
            v_result.append(vA[i] + vB[i])
        v_result = [0 if x < 0 else (255 if x > 255 else x) for x in v_result]
    elif alu == 9:
        #subvv
        for i in range(16):
            v_result.append(vA[i] - vB[i])
        v_result = [0 if x < 0 else (255 if x > 255 else x) for x in v_result]
    elif alu == 10:
        #mulvv
        temp = 0
        for i in range(16):
            temp += vA[i] * vB[i]
        temp = 255 if temp > 255 else (0 if temp < 0 else temp)
        conv_result.append(temp)
    else:
        s_result = sA + sB
        

    if len(conv_result) == 16:
        conv_out = conv_result
        conv_addr = rD
        conv_write = 1

    return conv_out, conv_addr, conv_write, s_write, v_write, rD, s_result, v_result, ldr, wb, mem_rw, mem_v, b_taken, b_addr, conv_result

def Memory(conv_out, conv_addr, conv_write, s_write, v_write, rD, s_result, v_result, ldr, wb, mem_rw, mem_v, data_int_mem):

    conv_out = conv_out
    conv_addr = conv_addr
    conv_write = conv_write

    rD = rD
    s_result = s_result
    v_result = v_result

    smem = data_int_mem[s_result]
    vmem = data_int_mem[s_result]

    ldr = ldr
    wb = wb

    if mem_rw:
        if mem_v:
            if type(v_write) == int:
                sys.exit()
            result_mem.append(v_write)
        else:
            result_mem.append(s_write)
    
    return conv_out, conv_addr, conv_write, rD, s_result, v_result, smem, vmem, ldr, wb, data_int_mem

def Writeback(conv_out, conv_addr, conv_write, rD, s_result, v_result, smem, vmem, ldr, wb, sReg, vReg):

    if wb == 1:
        sReg[rD] = smem if ldr == 1 else s_result
    elif wb == 2:
        vReg[rD] = vmem if ldr == 1 else v_result
    else:
        pass

    if conv_write:
        vReg[conv_addr] = conv_out

    return sReg, vReg

def NPU_sim():
    global pc, inst_counter
    sReg = [0 for i in range(32)]
    vReg = [o for o in range(32)]

    pc_inc = 0

    b_taken = 0
    b_addr = 0
    j_addr = 0

    inst = 0
    sA = 0
    sB = 0
    vA = []
    vB = []
    rD = 0
    strd = 0
    ldr = 0
    jmp = 0
    b = 0
    wb = 0
    alu = 0
    setcc = 0
    mem_rw = 0
    mem_v = 0
    conv_en = 0

    conv_result = []
    conv_out = []
    conv_addr = 0
    conv_write = 0

    s_write = 0
    v_write = []

    smem = 0
    vmem = []

    
    data_int_mem = []
    for i in range(0, len(data_mem)):
        data = []
        for j in range(0, 32, 2):
            data.append(int("0x"+data_mem[i][j:j+2], 16))
        data_int_mem.append(data)
    
    for i in range(0, len(data_mem)):
        data_int_mem.append(0)

    data_int_mem[0] = [-1, -2, -1, 0, 0, 0, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0]


    while pc <= len(inst_str_mem) - 2:

        pc = PC_logic(pc_inc, b_addr, j_addr, b_taken, jmp)

        pc, pc_inc, inst = Fetch(pc)

        pc, sA, sB, vA, vB, rD,strd, ldr, jmp, b, wb, alu, setcc, mem_rw, mem_v, conv_en = Decode(pc, inst, sReg, vReg)

        conv_out, conv_addr, conv_write, s_write, v_write, rD, s_result, v_result, ldr, wb, mem_rw, mem_v, b_taken, b_addr, conv_result = Execute(pc, sA, sB, vA, vB, rD, strd, ldr, b, wb, alu, setcc, mem_rw, mem_v, conv_en, b_addr, conv_result)

        if b_taken:
            continue

        conv_out, conv_addr, conv_write, rD, s_result, v_result, smem, vmem, ldr, wb, data_int_mem = Memory(conv_out, conv_addr, conv_write, s_write, v_write, rD, s_result, v_result, ldr, wb, mem_rw, mem_v, data_int_mem)

        sReg, vReg = Writeback(conv_out, conv_addr, conv_write, rD, s_result, v_result, smem, vmem, ldr, wb, sReg, vReg)


NPU_sim()

with open("ISA_simulator_result.txt", "w") as file:
    for data in result_mem:
        file.write(f'{data}\n')