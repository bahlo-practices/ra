// Loesung Termin6 Rechnerarchitektur WS2011
// Name: 	Matrikelnummer:
// Name: 	Matrikelnummer:
// Datum:

@ in R0 wird die Adresse des zu durchsuchenden Text erwartet.
@ in R1 wird die Adresse des zu suchendenn Text erwartet.
@ sollte R0 auf einen leeren String zeigen,
@ oder der gesuchte Text nicht gefunden werden,
@ so wird in R0 der Wert 0 zurueck geliefert.
@ zeigt R1 auf einen leeren String so wird in R0 der Wert 0 zurueck gegeben

@ Register-�bersicht
@ r0 = zu durchsuchender string
@ r1 = suchstring
@ r2 = hitz�hler
@ r3 = zu durchsuchender string f�r loop
@ r4 = zu durchsuchender string f�r innerloop
@ r5 = suchstring
@ r6 = backup von r0
@ r7 = backup von r1
 
	.file	"searchStringInString.S"
	.text
	.align	2
	.global	searchStringInString
	.type	searchStringInString, %function
	
searchStringInString:

	@ Backup von nicht-scratch-registern
	STMFD r13!, {r4-r10}
	
	@ Variablen
	MOV r2, #0 @ Hitz�hler
	
	@ Beide Strings 
	@ LDRB oder? War LDR
	LDRB r3, [r0] @ String nach r3 (8-Bit)
	LDRB r4, [r1] @ Suchstring nach R4 (8-Bit)
	
	@ �berpr�fen, ob einer der Strings leer ist
	CMP r3, #0
	BEQ end @ Wenn String leer, ende
	CMP r4, #0
	BEQ end @ Wenn Suchstring leer, ende
	
	MOV r6, r0 @ Zu durchsuchender String backup
loop:
	LDRB r3, [r6], #1 @ Addr f�r zu durchsuchender String f�r loop	
	MOV r7, r1 @ Suchstring Backup
	LDRB r5, [r1] @ Wert f�r Suchstring
	
	CMP r3, #0 @ Beim Ende vom zu durchsuchenden String ende
	BEQ end
	
	CMP r3, r5 @ Wenn Zeichen gleich, innerloop
	BNE loop
	
	MOV r4, r6 @ r6 in r4 zwischenspeichern, damit beim n�chsten sprung nicht r6 ver�ndert wird
	
innerloop:
	LDRB r3, [r4], #1 @ Wert in r4 holen und r4 inkrementieren
	LDRB r5, [r7, #1]! @ N�chsten Wert aus r7 holen und r7 inkrementieren
	
	CMP r5, #0 @ Ende vom Suchstring, hit
	BEQ hit
	
	CMP r3, r5 @ Zeichen gleich?
	BEQ innerloop @ Ja: N�chste checken
	BNE loop @ Nein: Weitersuchen
	
hit:
	ADD r2, r2, #1 @ Hitz�hler hochz�hlen
	B loop
	
end:
	MOV r0, r2 @ Hitz�hler �bergeben
	LDMFD r13!, {r4-r10}
	
	MOV pc, lr


	
	.size	searchStringInString, .-searchStringInString

