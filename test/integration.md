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

## Compatibility with mdBook

Exit with zero when calling dummy `supports` subcommand:

```sh
$ emojitsu supports FOO
$ emojitsu supports BAR
$ emojitsu supports
```
