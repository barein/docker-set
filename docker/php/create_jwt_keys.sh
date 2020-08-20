#!/bin/sh
set -e

# Generate jwt key
if [ ! -f $JWT_SECRET_KEY ]; then
    mkdir -p $(dirname $JWT_SECRET_KEY)
    openssl genrsa -passout pass:${JWT_PASSPHRASE} -out $JWT_SECRET_KEY -aes256 4096
    openssl rsa -passin pass:${JWT_PASSPHRASE} -pubout -in $JWT_SECRET_KEY -out $JWT_PUBLIC_KEY

    chown $USER_ID:$GOUP_ID $JWT_SECRET_KEY $JWT_PUBLIC_KEY
fi

exec "$@"
