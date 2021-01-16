#!/usr/bin/env sh
#
# Open a bookmark file
#

if [ "$#" -eq 0 ]; then
    printf "usage: %s file [file ...]\n" "$0"
    exit 1
fi

for file in "$@"; do
    if [ ! -r "${file}" ]; then
        printf "%s: not a file: %s\n" "$0" "${file}"
        continue
    fi

    uri="$(sed -n -e '/^uri=/s/^uri=//p' < "${file}")"

    if [ -z "${uri}" ]; then
        printf '%s: no uri in bookmark file, or malformed file\n' "$0"
        continue
    fi

    if [ "$(printf "${uri}" | wc -l)" -gt 0 ]; then
        printf '%s: multiple uri in bookmark file\n' "$0"
        continue
    fi

    xdg-open "${uri}"
done
