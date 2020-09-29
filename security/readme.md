# Security and chryptography

## on 2020-09-25 i was giving a security task
I was to generate some security keys to sign an android package!

here is some info i have found on my quest after using some openssl commands from [this guide](https://wladimir-tm4pda.github.io/porting/release_keys.html)
``` bash
#!/bin/bash

AUTH='/C=NO/ST=Egersund/L=Nyaskaiveien 2/O=Android/OU=Android/CN=Android/emailAddress=navico.service@navico.com'
if [ "$1" == "" ]; then
        echo "Create a test certificate key."
        echo "Usage: $0 NAME"
        echo "Will generate NAME.pk8 and NAME.x509.pem"
        echo "  $AUTH"
        exit
fi
# 2048 initial. Upgraded to 4096 as described in https://confluence.navico.com/display/NEON/Certificate+Deployment
openssl genrsa -3 -out $1.pem 4096

openssl req -new -x509 -key $1.pem -out $1.x509.pem -days 10000 \
    -subj "$AUTH"

echo "Please enter the password for this key:"
openssl pkcs8 -in $1.pem -topk8 -outform DER -out $1.pk8 -passout stdin
```

In cryptography, X.509 is a standard defining the format of public key certificates.

**Certificate filename extensions**

There are several commonly used filename extensions for X.509 certificates. Unfortunately, some of these extensions are also used for other data such as private keys.

.pem – (Privacy-enhanced Electronic Mail) Base64 encoded DER certificate, enclosed between "-----BEGIN CERTIFICATE-----" and "-----END CERTIFICATE-----"
.cer, .crt, .der – usually in binary DER form, but Base64-encoded certificates are common too (see .pem above)
.p7b, .p7c – PKCS#7 SignedData structure without data, just certificate(s) or CRL(s)
.p12 – PKCS#12, may contain certificate(s) (public) and private keys (password protected)
.pfx – PFX, predecessor of PKCS#12 (usually contains data in PKCS#12 format, e.g., with PFX files generated in IIS)
PKCS#7 is a standard for signing or encrypting (officially called "enveloping") data. Since the certificate is needed to verify signed data, it is possible to include them in the SignedData structure. A .P7C file is a degenerated SignedData structure, without any data to sign.[citation needed]

PKCS#12 evolved from the personal information exchange (PFX) standard and is used to exchange public and private objects in a single file.[citation needed]