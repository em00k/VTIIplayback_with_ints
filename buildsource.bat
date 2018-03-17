.\tools\sjasmplus.exe source.asm 
.\tools\sjasmplus.exe sourceint.asm
.\tools\bin2tap.exe source.bin -a 32768 -o source.tap
.\tools\bin2tap.exe sourceint.bin -a 32768 -o sourceint.tap
copy /b loader.tap+source.tap source_output.tap
copy /b loader.tap+sourceint.tap source_outputint.tap
del source.tap /q
del sourceint.tap /q
del source.bin /q
del sourceint.bin /q
del source.out /q
del sourceint.out /q
source_output.tap
