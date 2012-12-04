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
LDR r0, [r0] //tabelle in r0 laden
LDRB r1, [r0] // adresse von adresse von tab1 nach r1 laden (8-bit)


ADR r4, TAB2 //adresse der tabelle 2
LDR r2, [r4] //tabelle 2 in r2 laden
MOV r3, r2 //laden des ersten wertes in r3
LDR r2, [r2] // adresse wieder in r2
SUB r2, r2, #1 // nehmen einen wert obendrüber

STR r1,[r3], #4 // r1 + 4 wird in addr von r3 gesp

SUB r1, r1, #1 // r1--
MOV r6, r1 // r1 nach r6
SUB r10, r1, #1 // r1-- nach r10
		
kopieren:
@ hier Ihr Programm zum Kopieren einer Byte-Tabelle (je 8Bit) in eine Word-Tabelle (je 32Bit) einfuegen


LDRB r5, [r0, #1]! // r5 = r0 + 1, danach r0++
LSL r5, #24 // r5 wird um 24 stellen nach links verschoben, rest 0en
ASR r5, #24 // r5 wird um 24 stellen nach rechts verschoben, 1. bit kopiert für vorz
STR r5, [r3], #4 // [r3] = r5 + 4
SUBS r1, r1, #1 // r1--
BNE kopieren // wenn z-flag nicht gesetzt, nochmal

//vorzeichen:
@ hier Ihr Programm um die 8Bit-Zahlen auf vorzeichenrichtige 32Bit-Zahlen zu wandeln
// schon gemacht, zeile 36-37
		
	
sortieren:
@ hier Ihr Programm um die vorzeichenrichtige Zahlen in Liste2 zu sortieren
LDR r2, [r4] // laden adresse [r4] (adrr von tab2) in r2
ADD r2, r2, #4  // überspringen das erste, weil nur die anzahl der wete
MOV r3, r10 // r10 = anzahl
	sort:
	LDR r7, [r2] // wert von addr von r2 nach r7
	LDR r8, [r2, #4] // r8 = nächster wert nach r7 (addr von r2 + 4)
	CMPGE r7, r8 // r7 >= r8, dann:
	MOVGE r9, r7 // r9 = r7
	MOVGE r7, r8 // r7 = r8
	MOVGE r8, r9 // r8 = r9
	STR r7, [r2] // r7 = addr von bereits erhötem r2
	STR r8, [r2, #4]! // r8 = [r2 + 4], r2 = r2 + 4
	SUBS r3, r3, #1 // r3-- weil die anzahl weniger ist
	BNE sort // wenn zero flag nicht gesetzt ist (r3 != 0), nochmal sortieren


SUBS R6, R6, #1 // r6--
BNE sortieren // wenn r6 > 0, sortieren (mal die anzahl zur sicherheit)

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

