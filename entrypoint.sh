#!/bin/bash -l
SIGUL_PASS_FILE=/etc/sigul/sigul-pass

echo "$SIGUL_IP" "$SIGUL_URI" >> /etc/hosts
mkdir -p /etc/sigul
echo "$SIGUL_CONF" > /etc/sigul/client.conf

echo "$SIGUL_PASS" > $SIGUL_PASS_FILE

cd $HOME
gpg --batch --passphrase "${SIGUL_PASS}" -o sigul.tar.xz -d <<< "${SIGUL_PKI}"
tar Jxf sigul.tar.xz

# Any future use of $SIGUL_PASSWORD needs to have it null terminated
sed -i 's/$/\x0/' "${SIGUL_PASS_FILE}"

# $1 is sign-type and $2 is sign-object
cd $GITHUB_WORKSPACE
sigul --batch $1 -a -o test.asc odpi-release-2021 $2 < "${SIGUL_PASS_FILE}"
pwd
ls -al
