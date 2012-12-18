//
// EXERCISE 2
//
    .file "aufgabe2.S"
    .text           @ legt eine Textsection fuer ProgrammCode + Konstanten an
    .align 2        @ sorgt dafuer, dass nachfolgende Anweisungen auf einer durch 4 teilbaren Adresse liegen
                    @ unteren 2 Bit sind 0
    .global main    @ nimmt das Symbol main in die globale Sysmboltabelle auf
    .type main,function
main:
    push {lr}

    bl    up1

    pop {pc}

// UP1
// - nur Scratchregister
// - keine Blattroutine (keine Unterprogramm-Aufrufe)
up1:
    push {lr}

    mov r0, #0      // r0 = 0
    mov r1, #12
    mov r2, #3
    add r0, r1, r2  // r0 = 15
    bl up3          // springe in up3

    pop {pc}


// UP2
// - nur Scratchregister
// - Blattroutine
up2:
    add r0, r1


// UP3
// - keine Scratchregister
// - keine Blattroutine
up3:
    push {r4-r5, lr}

    mov r4, r0          // r4 = r0 = 15
    mov r5, #0xffffffff // r5 = 0xffffffff
    eor r5, r4, r5      // r5 = 2er-Komplement von r4-1
    add r5, #1          // r5 = Zweierkomplement von r4
    mov r1, r5          // r1 = r5
    bl up2

    pop {r4-r5, pc}

.Lfe1:
    .size    main,.Lfe1-main

// End of File
