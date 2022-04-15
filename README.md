# `pass-open-doc`

Open a password from your Pass Unix Password Manager via `xdg-open`.

This facilitates opening and interacting with images or filetypes other than raw text that are stored with Pass.

## Installation

Download this script and place it under your `$PATH`. You should have `gpg` installed.

## Usage

Just point `pass-open-doc` to one of your files in your password store either with their full path or relative to the password store root.

```
$ pass-open-doc -h

Open a gpg-encrypted, optionally pass-stored, file
Usage: /home/berger/dotfiles/bash_scripts/pass-open-doc [-g|--gpg_id <arg>] [-h|--help] <input-file>
        <input-file>: gpg-encrypted file to open. You can either use the full path to the file or just the name of the pass-stored item
        -g, --gpg_id: gpg-id to use. (default: '/home/berger/.password-store/.gpg-id')
        -h, --help: Prints help
```

## Completions

There's a fish-completion script you can use. See the [completions](/completions) directory
