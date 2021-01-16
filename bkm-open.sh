#!/usr/bin/env sh
#
# Open a bookmark file
#

if [ "$#" -ne 1 ]; then
    printf "usage: %s file\n" "$0"
    exit 1
fi

if [ ! -r "$1" ]; then
    printf "%s: not a file: %s\n" "$0" "$1"
    exit 2
fi

uri="$(sed -n -e '/^uri=/s/^uri=//p' < "$1")"

if [ -z "${uri}" ]; then
   printf '%s: no uri in bookmark file, or malformed file\n' "$0"
   exit 3
fi

if [ "$(printf "${uri}" | wc -l)" -gt 0 ]; then
    printf '%s: multiple uri in bookmark file\n' "$0"
    exit 3
fi

exec xdg-open "${uri}"
