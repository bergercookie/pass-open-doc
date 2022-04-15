#!/usr/bin/env fish
# Originally found in the password-store repo.
# https://github.com/zx2c4/password-store/blob/master/src/completion/pass.fish-completion

set PROG 'pass-open-doc'

function __fish_pass_get_prefix
    set -l prefix "$PASSWORD_STORE_DIR"
    if [ -z "$prefix" ]
        set prefix "$HOME/.password-store"
    end
    echo "$prefix"
end

function __fish_pass_needs_command
    set -l cmd (commandline -opc)
    if [ (count $cmd) -eq 1 -a $cmd[1] = $PROG ]
        return 0
    end
    return 1
end

function __fish_pass_print_gpg_keys
    set -l gpg gpg2
    command -sq $gpg; or set gpg gpg
    $gpg --list-keys | grep uid | sed 's/.*<\(.*\)>/\1/'
end

function __fish_pass_print
    set -l ext $argv[1]
    set -l strip $argv[2]
    set -l prefix (__fish_pass_get_prefix)
    printf '%s\n' "$prefix"/**"$ext" | sed "s#$prefix/\(.*\)$strip#\1#"
end

function __fish_pass_print_entry_dirs
    __fish_pass_print "/"
end

function __fish_pass_print_entries
    __fish_pass_print ".gpg" ".gpg"
end

function __fish_pass_print_entries_and_dirs
    __fish_pass_print_entry_dirs
    __fish_pass_print_entries
end


complete -c $PROG -e
complete -c $PROG -f -A -n '__fish_pass_needs_command' -a help -d 'Command: show usage help'
complete -c $PROG -f -A -n '__fish_use_subcommand' -a "(__fish_pass_print_entries)"
