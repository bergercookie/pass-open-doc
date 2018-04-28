# Pass Utils

## Description

Utility scripts for the [Pass Unix Manager](https://www.passwordstore.org/)

* pass-open-doc - Script for decrypting and viewing docs stored in the Pass Unix
    Password Manager.
* **[WIP]** pass-import-from-evernote
  * https://github.com/evernote/evernote-sdk-python3
  * https://github.com/evernote/evernote-sdk-python


## Contributing

Bash scripts use the [argbash](https://github.com/matejak/argbash) tool to
generate the command line arguments. Instead of editing the top-level scripts
edit the template files located under `bash_templates/`. Then use the
`helpers/generate_bash_scripts.sh` to generate the actual scripts

```sh
./helpers/generate_bash_scripts.sh && ./pass-open-doc <file-to-decrypt>
```

