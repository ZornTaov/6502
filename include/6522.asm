// All info taken from w65c22 datasheet
PORTB = $6000		// I/¯O Register "B"
PORTA = $6001		// I/¯O Register "A"
DDRB  = $6002		// Data Direction Register "B"
DDRA  = $6003		// Data Direction Register "A"
T1CFL = $6004		// TIMER 1 Counter Format Low (page 14)
T1CFH = $6005		// TIMER 1 Counter Format High (page 14)
T1LFL = $6006		// TIMER 1 Latch Format Low (page 15)
T1LFH = $6007		// TIMER 1 Latch Format High (page 15)
T1CFL = $6008		// TIMER 2 Counter Format Low (page 19)
T1CFH = $6009		// TIMER 2 Counter Format High (page 19)
SR    = $600a		// Shift Register (page 20)
ACR   = $600b		// Auxiliary Control Register (page 16)
PCR   = $600c		// Peripheral Control Register (page 12-13)

IFR   = $600d		// Interrupt Flag Register (page 26)
.region Interrupt Flag Register
IFR_IRQ = %10000000 
IFR_T1  = %01000000 
IFR_T2  = %00100000 
IFR_CB1 = %00010000 
IFR_CB2 = %00001000 
IFR_SR  = %00000100 
IFR_CA1 = %00000010 
IFR_CA2 = %00000001 
.endregion

IER   = $600e		// Interrupt Enable Register (page 27)
.region Interrupt Enable Register
IER_CLR = %00000000 // Clear enable flags
IER_SET = %10000000 // Set enable flags
IER_T1  = %01000000 
IER_T2  = %00100000 
IER_CB1 = %00010000 
IER_CB2 = %00001000 
IER_SR  = %00000100 
IER_CA1 = %00000010 
IER_CA2 = %00000001 
.endregion