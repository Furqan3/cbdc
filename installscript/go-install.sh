#!/bin/bash
set -e

GVERSION="1.17"
GFILE="go$GVERSION.linux-amd64.tar.gz"

GOPATH="$HOME/projects/go"
GOROOT="/usr/local/go"
if [ -d $GOROOT ]; then
    echo "Installation directories already exist $GOROOT"
    exit 1
fi

mkdir -p "$GOROOT"
chmod 777 "$GOROOT"

wget --no-verbose https://storage.googleapis.com/golang/$GFILE -O $TMPDIR/$GFILE
if [ $? -ne 0 ]; then
    echo "Go download failed! Exiting."
    exit 1
fi

tar -C "/usr/local" -xzf $TMPDIR/$GFILE

cp -f "$HOME/.bashrc" "$HOME/.bashrc.bkp"

touch "$HOME/.bashrc"
{
    echo ''
    echo '# GOLANG'
    echo 'export GOROOT='$GOROOT
    echo 'export GOPATH='$GOPATH
    echo 'export GOBIN=$GOPATH/bin'
    echo 'export PATH=$PATH:$GOROOT/bin:$GOBIN'
    echo ''
} >> "$HOME/.bashrc"
source "$HOME/.bashrc"
echo "GOROOT set to $GOROOT"

mkdir -p "$GOPATH" "$GOPATH/src" "$GOPATH/pkg" "$GOPATH/bin" "$GOPATH/out"
chmod 777 "$GOPATH" "$GOPATH/src" "$GOPATH/pkg" "$GOPATH/bin" "$GOPATH/out"
echo "GOPATH set to $GOPATH"

rm -f $TMPDIR/$GFILE
