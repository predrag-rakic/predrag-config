#!/bin/sh

#
# ARGS
#
quiet=0
while getopts "qh" opt; do
    case "$opt" in
        q)  quiet=1 ;;
        h)
            echo "Usage: $(basename $0) [-q] [destdir]";
            echo "   destdir  - Destination dir (default is $HOME)"
            echo "   -q       - Quiet"
            echo "   -h       - Help"
            exit 1 ;;
    esac
done

shift $(expr $OPTIND - 1)

#
# HOME
#
home=$1
if [ -z "$home" ]; then
    home=$HOME
fi

echo -n "* Configuring '$home' (y/N)? "
read ans

#
# CONFIRM
#
if [ "$ans" != "Y" -a "$ans" != "y" ]; then
    echo "* Aborted"
    exit 1
fi

#
# TARGETS
#
cfgdir=$(dirname $0)
ignore=" -regextype posix-extended -and -not -regex '.*/#.*#|.*\.hg.*|.*\.git/.*|.*~|.*configure\.sh|.*README\.md|.*AutoHotkey.*|'"

files=$(find "$cfgdir" \( -type f -or -type l \) $ignore -print)

hacks="
chmod 700 ~/.ssh
mkdir -p ~/.ssh/ctrl
mkdir -p ~/.local/share/nautilus
rm -f ~/.local/share/nautilus/scripts
if [ -d ~/.gnome2/nautilus-scripts ]; then ln -f -s ~/.gnome2/nautilus-scripts ~/.local/share/nautilus/scripts; fi
if [ \$(tmux -V | grep '2.1') ]; then ln -fs ~/.tmux.conf-2.1 ~/.tmux.conf; fi
"

#
# CONFIGURE
#
IFS="
"

echo "* Configuring files ..."
for f in $files; do
    destdir=${f%/*}              # strip file path
    destdir=${destdir#$cfgdir}   # strip cfgdir part
    destdir=$home$destdir        # goes to the home dir

    srcfile=$(readlink -e $f)    # absoulte path
    destfile=$destdir/${f##*/}

    if [ ! -d "$destdir" ]; then
        rm -f "$destdir"
    fi

    if [ "$quiet" != "1" ]; then
        echo $destfile
    fi

    mkdir -p "$destdir"
    rm -f "$destfile"
    ln -s "$srcfile" "$destfile"
done

echo "* Applying hacks ..."

for hack in $hacks; do
    if [ "$quiet" != "1" ]; then
        echo $hack
    fi

    eval $hack
done

echo "* Done"
