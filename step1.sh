#!/bin/bash
PW=$1
TELNUM=$2
if ! [ -r ${PW} ]; then exit 1; fi
if ! [ -r bin/wa_pbkdf2 ]; then gcc -o bin/wa_pbkdf2 src/wa_pbkdf2.c -lcrypto; fi

    dd if=${PW} of=tmp/pw_salt bs=1 skip=29 count=4
    hexdump -e '2/1 "%02x"' pw_salt
    dd if=${PW} of=tmp/pw_iv bs=1 skip=33 count=16
    dd if=${PW} of=tmp/pw_ekey bs=1 skip=49 count=20

    echo -n 'c2991ec29b1d0cc2b8c3b7556458c298c29203c28b45c2973e78c386c395' | xxd -r -p > tmp/pbkdf2_pass.bin
    echo -n $TELNUM | hexdump -e '2/1 "%02x"' | xxd -r -p >> tmp/pbkdf2_pass.bin
