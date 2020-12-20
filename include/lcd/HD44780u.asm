
SETDDRAM = %10000000 // Sets DDRAM address starting at 0. DDRAM data is sent and received after this setting
SETCGRAM = %01000000 // Sets CGRAM address starting at 0 incremented by 8. CGRAM data is sent and received after this setting

FUNCSET  = %00100000 // Sets interface data length (DL), number of display lines (N), and character font (F).
.region FUNCTION SET
FS_DL    = %00010000 // Sets the interface data length. Data is sent or received in 8-bit lengths (DB7 to DB0) when DL is 1, and in 4-bit lengths (DB7 to DB4) when DL is 0.When 4-bit length is selected, data must be sent or received twice.
FS_N     = %00001000 // number of display lines (N)
FS_F     = %00000100 // character font (F)
.endregion

DISPSHFT = %00010000 // Moves cursor and shifts display without changing DDRAM contents
.region DISPLAY SHIFT
DS_SC    = %00001000 // screen 0, cursor 1
DS_RL    = %00000100 // right 0, left 1
.endregion

DISPCTRL = %00001000
.region DISPLAY CONTROL
DC_D     = %00000100 // The display is on when D is 1 and off when D is 0. When off, the display data remains in DDRAM, but can be displayed instantly by setting D to 1.
DC_C     = %00000010 // The cursor is displayed when C is 1 and not displayed when C is 0. 
DC_B     = %00000001 // The character indicated by the cursor blinks when B is 1.
.endregion

ENTRYMD  = %00000100
.region ENTRY MODE
EM_ID    = %00000010 // I/D: Increments (I/D = 1) or decrements (I/D = 0) the DDRAM address by 1 when a character code is written into or read from DDRAM. The cursor or blinking moves to the right when incremented by 1 and to the left when decremented by 1. The same applies to writing and reading of CGRAM.
EM_S     = %00000001 // S: Shifts the entire display either to the right (I/D = 0) or to the left (I/D = 1) when S is 1. The display does not shift if S is 0. If S is 1, it will seem as if the cursor does not move but the display does. The display does not shift when reading from DDRAM. Also, writing into or reading out from CGRAM does not shift the display.
.endregion

MOVEHOME = %00000010 // Return home sets DDRAM address 0 into the address counter, and returns the display to its original status if it was shifted. The DDRAM contents do not change. The cursor or blinking go to the left edge of the display (in the first line if 2 lines are displayed).

CLRSCR   = %00000001 // Clear display writes space code 20H (character pattern for character code 20H must be a blank pattern) into all DDRAM addresses. It then sets DDRAM address 0 into the address counter, and returns the display to its original status if it was shifted. In other words, the display disappears and the cursor or blinking goes to the left edge of the display (in the first line if 2 lines are displayed). It also sets I/D to 1 (increment mode) in entry mode. S of entry mode does not change.

.region HD44780U PINS
PORTB_PINS = %11111111
PORTA_PINS = %11100000
E  = %10000000	// Enable Pin
RW = %01000000	// Read/Write Pin
RS = %00100000	// Register Pin
.endregion

.region Base instructions
lcd_wait:
.if Debug == true
  rts
.endif
  pha
  lda #%00000000  	// Port B is input
  sta DDRB
lcdbusy:
  lda #RW 			// set read/write high
  sta PORTA
  lda #(RW | E) 	// set enable high
  sta PORTA
  lda PORTB 		// get PORTB status
  and #%10000000
					// if PORTB != 1<<7
  bne lcdbusy 		// loop to lcdbusy
					// else
  lda #RW 			// set enable low
  sta PORTA
  lda #%11111111  	// Port B is output
  sta DDRB
  pla
  rts				// return
  
lcd_instruction:
  jsr lcd_wait
  sta PORTB
  lda #0         	// Clear RS/RW/E bits
  sta PORTA
  lda #E         	// Set E bit to send instruction
  sta PORTA
  lda #0         	// Clear RS/RW/E bits
  sta PORTA
  rts				// return
.endregion

print_char:
  jsr lcd_wait
  sta PORTB
  lda #RS         	// Set RS// Clear RW/E bits
  sta PORTA
  lda #(RS | E)   	// Set E bit to send instruction
  sta PORTA
  lda #RS         	// Clear E bits
  sta PORTA
  rts				// return

.region EXPIREMENTAL
write_char:
  jsr lcd_wait
  sta PORTB
  lda #(RW | RS)   	// Set RS// Clear RW/E bits
  sta PORTA
  lda #(RW | RS | E)// Set E bit to send instruction
  sta PORTA
  lda #(RW | RS)         	// Clear E bits
  sta PORTA
  lda #0        	// Clear E bits
  sta PORTA
  rts				// return
  
make_char:
.if Debug == false
  rts
.endif
.breakpoint
  lda SETCGRAM 		// make new character
  jsr lcd_instruction
  ldy #8
send_char:
  lda char1,x
  jsr write_char
  dey				// y--
					// if message+y = '\0'
  bne send_char 	// loop to send_char
					// else
  rts				// return

.endregion