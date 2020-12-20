.setting "DebugCommand", "cmd.exe /c start cmd.exe /c wsl.exe /mnt/d/Dev/6502/x6502 /mnt/d/Dev/6502/HelloDragon.bin"
.setting "LaunchCommand", "cmd.exe /c start cmd.exe /c wsl.exe /mnt/d/Dev/6502/x6502 -r /mnt/d/Dev/6502/HelloDragon.bin"

.include "6522.asm"
.org $8000
Debug = true
.include "lcd/HD44780u.asm"


.region RAM addresses
counter = 0x10
.endregion

reset:
  ldx #$ff // Load 255 to index x
  txs 	   // push to stack
  cli

  lda #$82
  sta IER
  lda #$00
  sta PCR

  lda #PORTA_PINS // Set top 3 pins on port A to output
  sta DDRA
  lda #PORTB_PINS // Set all pins on port B to output
  sta DDRB

  lda #(FUNCSET | FS_DL | FS_N) // Set 8-bit mode// 2-line display// 5x8 font
  jsr lcd_instruction
  lda #(DISPCTRL | DC_D | DC_C) // Display on// cursor on// blink off
  jsr lcd_instruction
  lda #(ENTRYMD | EM_ID) // Increment and shift cursor// don't shift display
  jsr lcd_instruction
  lda #CLRSCR // Clear display
  jsr lcd_instruction
  ldx #0

  //jsr make_char

print:
  lda message,x
				// if message+x = '\0'
  beq print2
				// else
  jsr print_char
  inx			// x++
  jmp print 	// loop to print
print2:
  lda $40
  //jsr print_char
  cli

  jmp main_loop

main_loop:
  jmp main_loop



irqb:
  pha
  lda PORTA
  pla
  rti

nmib:
  rti

  .org $b000		// strings
message: .asciiz "Hello, Dragon!"

  .org $c000		// characters
char1: 	.byte %00001110,
		.byte %00000011,
		.byte %00000101,
		.byte %00001001,
		.byte %00010000,
		.byte %00000000,
		.byte %00000000,
		.byte %00000000

  .org $fffa
  .word nmib
  .word reset	  	// set $fffc-$fffd to 8000
  .word irqb