#!/bin/sh

pip3 install -r requirements-dev.txt --user
pre-commit install
pre-commit autoupdate
#chmod a+x ./dev-deploy.sh

if [ ! -f ".env.dev" ]; then
    touch .env.dev
fi

if [ -d /run/user/${UID}/gvfs/smb-share:server=hassio,share=addons/ ]; then
    ln -s /run/user/${UID}/gvfs/smb-share:server=hassio,share=addons/ dev-addons
fi
