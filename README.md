# 6502
 6502 stuff for Ben Eaters 6502 project

# Building using Windows 10
Using wsl, build sims/x6502 with ./build (make sure there's no CR characters in that file. This marks that module as dirty so undo the change after)
Move the x6502 file back to the root folder
Install retroassembler and it's VSCode extension and set the path in .vscode/tasks.json.
Fix DebugCommand and LaunchCommand paths to your current paths (use linux path formatting for wsl)
Press F5 and it should compile using RetroAssembler and run the x6502 simulator

# Building using linux/mac
Not sure actually, you might get lucky and other stuff will work for you!  You just need a assembly assembler (namely for 6502/65c02) and an optional simulator like x6502 that is submoduled.

# Writing your bin file
There are many different EEPROM writers to use.  I'm currently using an Arduino Mega 2560 with a modified version of https://github.com/JOliverasC/eeprom-writer to write to my EEPROM as shown below.

![EEPROM writer](EEPROM%20writer.png)

PINS:
```
kPin_Addr0   = 66;
kPin_Addr1   = 65;
kPin_Addr2   = 64;
kPin_Addr3   = 63;
kPin_Addr4   = 62;
kPin_Addr5   = 59;
kPin_Addr6   = 58;
kPin_Addr7   = 57;
kPin_Addr8   = 4;
kPin_Addr9   = 3;
kPin_Addr10  = 15;
kPin_Addr11  = 2;
kPin_Addr12  = 56;
kPin_Addr13  = 5;
kPin_Addr14  = 55;
kPin_Data0   = 67;
kPin_Data1   = 68;
kPin_Data2   = 69;
kPin_Data3   = 21;
kPin_Data4   = 20;
kPin_Data5   = 19;
kPin_Data6   = 18;
kPin_Data7   = 17;
kPin_LED_Grn = 54;
kPin_LED_Red = 60;
kPin_nCE     = 16;
kPin_nOE     = 14;
kPin_nWE     = 6;
kPin_WaitingForInput = 13;
```
