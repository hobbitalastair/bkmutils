#!/usr/bin/env sh
#
# Create a bookmark file
#

if [ "$#" -ne 2 ]; then
    printf "usage: %s uri file\n" "$0"
    exit 1
fi
uri="$1"
file="$2"

if [ -e "${file}" ]; then
    printf '%s: file already exists: %s\n' "$0" "${file}"
    exit 2
fi

printf 'uri=%s\n' "${uri}" > "${file}"

