// Name:		Matrikelnummer:
// Name:		Matrikelnummer:
// Datum:

	.file	"aufgabe2.S"
	.text			@ legt eine Textsection fuer PrgrammCode + Konstanten an
	.align	2		@ sorgt dafuer, dass nachfolgende Anweisungen auf einer durch 4 teilbaren Adresse liegen
				@ unteren 2 Bit sind 0
	.global	main		@ nimmt das Symbol main in die globale Sysmboltabelle auf
	.type	main,function
main:

MOV R5,#0
MOV R0,#5
CMP R0,#0
BNE Marke1
BEQ Marke2



Marke1: MOV R5, #5
Marke2: MOV R5, #6


//MOVS R3, #3
//ADR R1, 
//MOVS R3, #2

//Marke:
//MOVS R3, #1
		
	
.Lfe1:
	.size	main,.Lfe1-main

// End of File
