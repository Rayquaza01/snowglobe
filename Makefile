build: snowglobe.p64.png

start:
	prt load /projects/snowglobe/src
	prt run

extract:
	prt cp -f /projects/snowglobe/snowglobe.p64.png/ /projects/snowglobe/src/

snowglobe.p64.png: src/main.lua
	prt cp -f /projects/snowglobe/src/ /projects/snowglobe/snowglobe.p64.png/
