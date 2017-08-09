#include <stdio.h>
#include <string.h>
#include <openssl/x509.h>
#include <openssl/evp.h>
#include <openssl/hmac.h>

int main(int argc, char *argv[])
{
    unsigned char pass[1024];      // passphrase read from stdin
    unsigned char salt[1024];      // salt
    int salt_len;                  // salt length
    int ic;                        // iteration
    unsigned char result[1024];    // result
    FILE *fp_salt;

    if ( argc != 3 ) {
        fprintf(stderr, "usage: %s salt_file iteration < passwd_file > binary_key_file \n", argv[0]);
        exit(1);
    }

    ic = atoi(argv[2]);

    fp_salt = fopen(argv[1], "r");
    if(!fp_salt) {
        fprintf(stderr, "error opening salt file: %s\n", argv[1]);
        exit(2);
    }

    salt_len=0;
    int ch; 
    while((ch = fgetc(fp_salt)) != EOF) {   
        salt[salt_len++] = (unsigned char)ch;   
    }   

        fclose(fp_salt);    

            fgets(pass, 1024, stdin);
                if ( pass[strlen(pass)-1] == '\n' )
                    pass[strlen(pass)-1] = '\0';

                    PKCS5_PBKDF2_HMAC_SHA1(pass, strlen(pass), salt, salt_len, ic, 16, result);

                    fwrite(result, 1, 16, stdout);

                    return(0);
}
