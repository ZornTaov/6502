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