 #/data/data/com.whatsapp/files/pw
 ./bin/wa_pbkdf2 tmp/pw_salt 16 < tmp/pbkdf2_pass.bin > tmp/pbkdf2_key.bin
 k=$(hexdump -e '2/1 "%02x"' tmp/pbkdf2_key.bin)
 iv=$(hexdump -e '2/1 "%02x"' tmp/pw_iv)
 openssl enc -aes-128-ofb -d -nosalt -in tmp/pw_ekey -K $k -iv $iv -out tmp/wa_password.key > /dev/null 2>&1
 base64 tmp/wa_password.key
