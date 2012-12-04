// Loesung Aufgabe 3 und 4 von Termin4 Rechnerarchitektur WS2011
// Name: 	Matrikelnummer:
// Name: 	Matrikelnummer:
// Datum:
	.file "aufgabe3.S"
	.text 		@ legt eine Textsection fuer PrgrammCode + Konstanten an
	.align 2 	@ sorgt dafuer, dass nachfolgende Anweisungen auf einer durch 4 teilbaren Adresse liegen	
			@ unteren 2 Bit sind 0
	.global main 	@ nimmt das Symbol main in die globale Sysmboltabelle auf
	.type main,function
main:
	stmfd sp!, {r4, r5, lr} @ Ruecksprungadresse und Register sichern
	
ADR r0, TAB1 //adresse der tabelle
LDR r0, [r0] //tabelle in r0 laden?
LDRB r1, [r0] 


ADR r4, TAB2 //adresse der tabelle 2
LDR r2, [r4] //tabelle 2 in r2 laden
MOV r3, r2 //laden des ersten wertes in r3
LDR r2, [r2] 	
SUB r2, r2, #1

STR r1,[r3], #4

SUB r1, r1, #1
MOV r6, r1
SUB r10, r1, #1
		
kopieren:
@ hier Ihr Programm zum Kopieren einer Byte-Tabelle (je 8Bit) in eine Word-Tabelle (je 32Bit) einfuegen


LDRB r5, [r0, #1]!
LSL r5, #24
ASR r5, #24
STR r5, [r3], #4
SUBS r1, r1, #1
BNE kopieren

//vorzeichen:
@ hier Ihr Programm um die 8Bit-Zahlen auf vorzeichenrichtige 32Bit-Zahlen zu wandeln

		
	
sortieren:
@ hier Ihr Programm um die vorzeichenrichtige Zahlen in Liste2 zu sortieren
LDR r2, [r4]
//LDR r2, [r2]
ADD r2, r2, #4 
MOV r3, r10
	sort:
	LDR r7, [r2]
	LDR r8, [r2, #4]
	CMPGE r7, r8
	MOVGE r9, r7
	MOVGE r7, r8
	MOVGE r8, r9
	STR r7, [r2]
	STR r8, [r2, #4]!
	SUBS r3, r3, #1
	BNE sort 


SUBS R6, R6, #1
BNE sortieren

fertig:
	ldmfd sp!, {r4, r5, pc} @ Ruecksprungadresse und Register

TAB1: .word Liste1
TAB2: .word Liste2 @ Beispiel um an Adressen aus anderen Segmenten zu kommen

.Lfe1:
	.size main,.Lfe1-main

// .data-Section fuer initialisierte Daten
	.data
// Erster Wert der Tabelle steht fuer die Anzahl (max. 64) der Werte der Tabelle

Liste1: .byte (Liste1Ende-Liste1), -9, 8, -7, 6, -5, 4, -3, 2, -1, 0, 127, 128
Liste1Ende:

// .comm-Section fuer nicht initialisierte Daten
	.comm Liste2, ((Liste1Ende-Liste1)*4) 	@ Speicherbereich mit der Groesse*4 von Liste1 reservieren

// End of File

