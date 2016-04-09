
cc() {
    "/opt/microchip/xc8/v1.37/bin/xc8" --pass1  --chip=18LF25K50 -Q -G  --double=24 --float=24 --emi=wordwrite --rom=-0-180B --opt=default,+asm,+asmfile,-speed,+space,-debug --addrqual=ignore --mode=free -P -N255 --warn=-3 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --codeoffset=0x180C --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"  \
    "$@"
}

ld() {
"/opt/microchip/xc8/v1.37/bin/xc8"  --chip=18LF25K50 -G --double=24 --float=24 --emi=wordwrite --rom=-0-180B --opt=default,+asm,+asmfile,-speed,+space,-debug --addrqual=ignore --mode=free -P -N255 --warn=-3 --asmlist --summary=default,-psect,-class,+mem,-hex,-file --codeoffset=0x180C --output=default,-inhx032 --runtime=default,+clear,+init,-keep,-no_startup,-download,+config,+clib,-plib --output=-mcof,+elf:multilocs --stack=compiled:auto:auto:auto "--errformat=%f:%l: error: (%n) %s" "--warnformat=%f:%l: warning: (%n) %s" "--msgformat=%f:%l: advisory: (%n) %s"    \
    "$@"


}

rm -rf tmp/
test -e tmp/ || mkdir tmp/

FILES="main.c bh-badge-animate.c"
OBJS=""

for F in $FILES; do
    echo "build ${F}"
    cc -otmp/${F/.c/.p1} ${F}
    OBJS+=" tmp/${F/.c/.p1}"
done
echo $OBJS

ld -mtmp/output.map --memorysummary tmp/memoryfile.xml -otmp/output.elf \
    ${OBJS}



