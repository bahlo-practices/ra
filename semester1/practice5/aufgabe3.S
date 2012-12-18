//
// EXERCISE 3
//
    .file "aufgabe3.S"
    .text           @ legt eine Textsection fuer ProgrammCode + Konstanten an
    .align 2        @ sorgt dafuer, dass nachfolgende Anweisungen auf einer durch 4 teilbaren Adresse liegen
                    @ unteren 2 Bit sind 0
    .global main    @ nimmt das Symbol main in die globale Sysmboltabelle auf
    .type main,function
main:
    adr r0, Total       // r0 = Zeiger fuer Total
    adr r1, Table       // r1 = Zeiger fuer Table
    adr r2, One         // r2 = Zeiger fuer One
    adr r5, Add_instr   // r5 = Zeiger fuer Add_instr
    adr r7, Count       // r7 = Zeiger fuer Count

Loop:      ldr r3, [r0] // r3 = Wert in Total
Add_instr: ldr r4, [r1] // r4 = naechster Wert in Table
    add r3, r4      // Total + aktueller Wert in Table
    str r3, [r0]    // speichere neuen Wert in Total
    ldr r6, [r5]    // r6 = Wert an der Addresse r5
    ldr r9, [r2]    // r9 = Wert in One
    add r6, r9      // r6 + r9
    str r6, [r5]    // r6 wieder an der Adresse r5 speichern
    ldr r8, [r7]    // r8 = Wert in Count
    subs r8, #1     // Count - 1 und Flags setzen
    str r8, [r7]    // Count abspeichern
    bge Loop        // wenn Count >= 0

Halt:
    bx    lr

//; Data definitions
Total: .word 0
One:   .word 4
Count: .word 4
Table: .word 39, 25, 4, 98, 17


.Lfe1:
    .size main,.Lfe1-main

// End of File
