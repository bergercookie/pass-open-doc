#!/usr/bin/env bash
# vi:syntax=sh
# vi:filetype=sh

# Current script decrypts and opens a gpg-encrypted document that is stored in
# the password-store of the *pass* Unix password manager. Under the hood uses
# xdg-mime to grab the file type and open it with the default application for
# its filetype.
#
# Currently runs on Linux platforms


set -e

function print_fatal_msg() {

printf "$1\nPExiting...\n"
exit 1

}

root="$HOME/.password-store/"

gpg_prog="$(which gpg)"
recipient=$(cat "$root/.gpg-id")
dst_file="/tmp/$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"

open_prog=
del_prog=
del_prog_flags=
if [[ $(uname) == "Linux" ]]; then
    del_prog=$(which shred)
    del_prog_flags="--remove"
elif [[ $(uname) == "Darwin" ]]; then
    del_prog=$(which srm)
else
    print_fatal_msg "Unknown platform \($(uname)\)"
fi

# Verify number of arguments
if [[ $# != 1 ]]; then
    print_fatal_msg "pass_open_doc <path_to_file>"
fi

# Verify that the path exists
fpath=$1
if ! [[ $(ls "${fpath}") ]]; then
    print_fatal_msg "Filepath ${fpath} doesn't exist."
fi

# Decrypt
${gpg_prog} --recipient "${recipient}" --decrypt  --output "${dst_file}" "${fpath}"

# Don't use xdg-open as it it launched as a different process, so the shell
# cannot wait until it finished...
#
# Determine the mime type
# https://unix.stackexchange.com/questions/114224/open-file-with-default-program-and-wait-until-the-app-is-terminated
ftype=$(xdg-mime query filetype "${dst_file}")
open_prog_raw=$(xdg-mime query default "${ftype}")
open_prog=$(echo "${open_prog_raw}" | sed 's/\..*//')

# remove the gibberish kde4-...Application.. from kde4 application names
open_prog=$(echo ${open_prog} | sed 's/kde4-\(.*\)Application.*/\1/')

${open_prog} "${dst_file}"

# Make sure I delete the destination file
printf "Removing output file...\n"
${del_prog} ${del_prog_flags} "${dst_file}"
printf "Done!\n"
exit 0
