.region ILI9341 COMMANDS
LCD_TFTWIDTH = 240  // ILI9341 max TFT width
LCD_TFTHEIGHT = 320 // ILI9341 max TFT height

LCD_NOP     = 0x00    // No-op register
LCD_SWRESET = 0x01    // Software reset register
LCD_RDDID   = 0x04    // Read display identification information
LCD_RDDST   = 0x09    // Read Display Status

LCD_SLPIN  = 0x10     // Enter Sleep Mode
LCD_SLPOUT = 0x11     // Sleep Out
LCD_PTLON  = 0x12     // Partial Mode ON
LCD_NORON  = 0x13     // Normal Display Mode ON

LCD_RDMODE     = 0x0a // Read Display Power Mode
LCD_RDMADCTL   = 0x0b // Read Display MADCTL
LCD_RDPIXFMT   = 0x0c // Read Display Pixel Format
LCD_RDIMGFMT   = 0x0d // Read Display Image Format
LCD_RDSELFDIAG = 0x0f // Read Display Self-Diagnostic Result

LCD_INVOFF   = 0x20   // Display Inversion OFF
LCD_INVON    = 0x21   // Display Inversion ON
LCD_GAMMASET = 0x26   // Gamma Set
LCD_DISPOFF  = 0x28   // Display OFF
LCD_DISPON   = 0x29   // Display ON

LCD_CASET = 0x2a      // Column Address Set
LCD_PASET = 0x2b      // Page Address Set
LCD_RAMWR = 0x2c      // Memory Write
LCD_RAMRD = 0x2e      // Memory Read

LCD_PTLAR    = 0x30   // Partial Area
LCD_VSCRDEF  = 0x33   // Vertical Scrolling Definition
LCD_MADCTL   = 0x36   // Memory Access Control
LCD_VSCRSADD = 0x37   // Vertical Scrolling Start Address
LCD_PIXFMT   = 0x3a   // COLMOD: Pixel Format Set

LCD_FRMCTR1 = 0xb1    // Frame Rate Control (In Normal Mode/Full Colors)
LCD_FRMCTR2 = 0xb2    // Frame Rate Control (In Idle Mode/8 colors)
LCD_FRMCTR3 = 0xb3    // Frame Rate control (In Partial Mode/Full Colors)
LCD_INVCTR  = 0xb4    // Display Inversion Control
LCD_DFUNCTR = 0xb6    // Display Function Control

LCD_PWCTR1 = 0xc0     // Power Control 1
LCD_PWCTR2 = 0xc1     // Power Control 2
LCD_VMCTR1 = 0xc5     // VCOM Control 1
LCD_VMCTR2 = 0xc7     // VCOM Control 2

LCD_RDID1  = 0xda     // Read ID 1
LCD_RDID2  = 0xdb     // Read ID 2
LCD_RDID3  = 0xdc     // Read ID 3
LCD_RDID4  = 0xdd     // Read ID 4

LCD_GMCTRP1 = 0xe0    // Positive Gamma Correction
LCD_GMCTRN1 = 0xe1    // Negative Gamma Correction
LCD_EN3G    = 0xf2    // Enable 3G

.endregion



.region ILI9341 PINS
PORTB_PINS = 0b00111100
PORTA_PINS = 0b11100000
SCK  = 0b10000000	// 
SDO  = 0b01000000	// 
CS   = 0b00100000	// 
RST  = 0b00010000	// 
DC   = 0b00001000	// 
//TCS  = 0b00000100	// 
//TIRQ = 0b00000010	// 
.endregion
LCD_startup: 	
	.byte LCD_PWCTR1  , 1, 0x23, // set GVDD to 4.6V
	.byte LCD_PWCTR2  , 1, 0x10, // UNKNOWN
	.byte LCD_VMCTR1  , 2, 0x3e, 0x28, // set VCOMH to 4.275V, VCOML to -1.5V
	.byte LCD_VMCTR2  , 1, 0x86, // set nVM to 1 and VMF to VMH –58 VML –58
	.byte LCD_MADCTL  , 1, 0x48, // set MX and BGR
	.byte LCD_VSCRSADD, 1, 0x00, // set scrolling start address to 0 (should be 2 parameters?)
	.byte LCD_PIXFMT  , 1, 0x55, // set RGB and MCU to 16 bits / pixel
	.byte LCD_FRMCTR1 , 2, 0x00, 0x18, // sets DIVA to 0 and frame rate to 79Hz and 24 clocks/line
	.byte LCD_DFUNCTR , 3, 0x08, 0x82, 0x27, // sets interval scan, REV to normally white, ISC to 5 frames, NL to 320, doesn't set PCDIV???
  	.byte LCD_EN3G    , 1, 0x02, // disables 3G
	.byte LCD_GAMMASET, 1, 0x01, // select gamma curve 1
	.byte LCD_GMCTRP1 , 15, 0x0F, 0x31, 0x2B, 0x0C, 0x0E, 0x08, 0x4E, 0xF1, 0x37, 0x07, 0x10, 0x03, 0x0E, 0x09, 0x00,
	.byte LCD_GMCTRN1 , 15, 0x00, 0x0E, 0x14, 0x03, 0x11, 0x07, 0x31, 0xC1, 0x48, 0x08, 0x0F, 0x0C, 0x31, 0x36, 0x0F,
	.byte LCD_NOP // finish startup

lcd_begin:
  // set rst high (initially held low)
  // for each of LCD_startup
    // if command is 0x0 then stop
    // send commend to LCD over 6522 SR
    // get number of params
    // loop until number
	  // send each param
	// end param loop
  // end startup loop
  // sleep out
  // display on


shift_cmd:
  //set d/c low
  jmp shift_out
shift_data:
  //set d/c high
shift_out:
  //set cs low
  //start 6522 sr using 110 phi2 clock control
  //wait for irqb
  //stop 6522 sr
  //set cs high