#!/bin/bash -l
echo $SIGUL_IP $SIGUL_URI >> /etc/hosts
# $1 is sign-type and $2 is sign-object
sigul --batch $1 odpi-release-2021 $2 < /etc/sigul/sigul-pass
