# Emojitsu

_A library and executable of techniques for dealing with unicode emoji_

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Emojitsu](#emojitsu)
    - [CLI Usage](#cli-usage)
        - [Examples](#examples)
            - [Emojify file contents to stdout](#emojify-file-contents-to-stdout)
            - [Emojify a file in place:](#emojify-a-file-in-place)
            - [Emojify from stdin](#emojify-from-stdin)

<!-- markdown-toc end -->

## CLI Usage

```sh
$ emojitsu --help=plain
NAME
       emojitsu - Techniques for dealing with emoji

SYNOPSIS
       emojitsu COMMAND ...

COMMANDS
       emojify
           Replace all names of the form :emoji_name: with the corresponding
           unicode

       find-name
           Find the (GitHub) name of an emoji given its unicode

       find-unicode
           Find the unicode of an emoji given its (GitHub) name

OPTIONS
       --help[=FMT] (default=auto)
           Show this help in format FMT. The value FMT must be one of `auto',
           `pager', `groff' or `plain'. With `auto', the format is `pager` or
           `plain' whenever the TERM env var is `dumb' or undefined.

       --version
           Show version information.

```

### Examples

Consider the following example file:

```sh
$ cat > ./emoji-names-example.md <<EOL \
> # Emoji Names :tada:\
> :woman_teacher: :woman_student: :woman_scientist:\
> :rowing_woman: :basketball_woman: :biking_woman:\
> EOL
```

#### Emojify file contents to stdout

```sh
$ emojitsu emojify ./emoji-names-example.md
# Emoji Names 🎉
👩‍🏫 👩‍🎓 👩‍🔬
🚣‍♀ ⛹‍♀ 🚴‍♀

```

#### Emojify a file in place:

```sh
$ emojitsu emojify --inplace ./emoji-names-example.md && cat ./emoji-names-example.md
# Emoji Names 🎉
👩‍🏫 👩‍🎓 👩‍🔬
🚣‍♀ ⛹‍♀ 🚴‍♀
```

#### Emojify from stdin

```sh
$ echo :fist: | emojitsu emojify
✊
```
