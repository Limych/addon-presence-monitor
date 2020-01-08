#!/bin/sh

pip3 install -r requirements-dev.txt --user
pre-commit install
pre-commit autoupdate
chmod a+x ./dev-deploy.sh

if [ -d /run/user/1001/gvfs/smb-share:server=hassio,share=addons/ ]; then
    ln -s /run/user/1001/gvfs/smb-share:server=hassio,share=addons/ dev-addons
fi
