# Integration tests

## Failures

Exit with non-zero when no file is found:

```sh
$ emojitsu emojify no-file-here
error: no-file-here: No such file or directory
[1]
```

Exit with non-zero when no emoji is found:

```sh
$ emojitsu find-unicode no-emoji-name
error: No entry found for no-emoji-name
[1]
```

Exit with non-zero when no name is found:

```sh
$ emojitsu find-name asdoipjf
error: No entry found for asdoipjf
[1]
```

## Compatibility as an mdBook preprocessor

Exit with zero when called with `supports foo` args:

```sh
$ emojitsu mdbook suport FOO
```

Emojifies stdin when called with mdbook subcommand

```sh
$ echo ":duck:" | emojitsu mdbook
🦆
```
