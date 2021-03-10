#!/usr/bin/env sh

WORKDIR=/mm-wiki

cd ${WORKDIR}

if [[ -e ${WORKDIR}/install.lock  ]]; then
    exec ./mm-wiki -conf conf/mm-wiki.conf
else
    exec ./install/install -port 8090
fi
