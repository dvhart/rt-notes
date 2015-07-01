#!/bin/sh

NOTES=""

find_notes () {
    NEW_PATCHES_PATH=$1
    NOTES_PATH=$2
    for p in `find ${NEW_PATCHES_PATH} -name \*.patch`; do
	pn=`basename $p .patch`
	for n in `find ${NOTES_PATH} -name \*.notes`; do
	    nn=`basename $n .patch.notes`
	    if [ "$pn" == "$nn" ]; then
		NOTES="${NOTES} $n"
	    fi
	done
    done
}

copy_notes() {
    NOTES_PATH=$1
    NEW_VERSION_PATH=$2

    if [ ! -d "${NEW_VERSION_PATH}" ]; then
	mkdir -p ${NEW_VERSION_PATH}
    fi

    cp ${NOTES} $NEW_VERSION_PATH
}

usage() {
    echo "Copy patch notes from an older release to newer one if"
    echo "the patch is still in the new release"
    echo ""
    echo "copy-notes.sh NEW_PATCHES_PATH NOTES_PATH NEW_NOTES_PATH"
    echo ""
    echo "e.g.:"
    echo ""
    echo "./copy-notes.sh ~/rt/patches/patches-4.0.5-rt4 ~/rt/rt-notes/4.0.4-rt1 ~/rt/rt-notes/4.0.5-rt4"
}

NEW_PATCHES_PATH=$1
NOTES_PATH=$2
NEW_VERSION_PATH=$3

if [[ -z $NEW_PATCHES_PATH ]] || [[ -z $NOTES_PATJ ]] || [[ -z $NEW_VERSION_PATH ]]; then
    usage
    exit 1
fi

find_notes $NEW_PATCHES_PATH $NOTES_PATH
copy_notes $NOTES_PATH $NEW_VERSION_PATH
