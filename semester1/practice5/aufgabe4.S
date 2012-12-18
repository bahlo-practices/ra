//
// EXERCISE 4
//
    .file    "aufgabe4.S"
    .text           @ legt eine Textsection fuer ProgrammCode + Konstanten an
    .align 2        @ sorgt dafuer, dass nachfolgende Anweisungen auf einer durch 4 teilbaren Adresse liegen
                    @ unteren 2 Bit sind 0
    .global main    @ nimmt das Symbol main in die globale Sysmboltabelle auf
    .type main,function
main:
    adr r0, Count   // Zeige auf Count
    ldr r1, [r0]    // lade Wert von Count in r1
    adr r0, Table   // r0 zeigt auf Table
    mov r2, #0      // r2 = 0

Loop:
    ldr r3, [r0], #4    // r3 = nächster Wert in Table
    add r2, r3          // r2  = r2 + aktueller Wert in Table
    subs r1, #1         // Count - 1 und Flags setzen
    bge Loop            // wenn Count >= 0

Halt:
    bx lr

    .data
Count: .word 4                  // Anzahl der Elemente
Table: .word 39, 25, 4, 98, 17  // The numbers to total...

.Lfe1:
    .size main,.Lfe1-main

// End of File


