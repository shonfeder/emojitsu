# Emojitsu

_Tiny executable techniques for dealing with emoji_

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Emojitsu](#emojitsu)
    - [Installation](#installation)
    - [CLI Usage](#cli-usage)
        - [Overview](#overview)
        - [Examples](#examples)
            - [Emojify file contents to stdout](#emojify-file-contents-to-stdout)
            - [Emojify a file in place](#emojify-a-file-in-place)
            - [Emojify from stdin](#emojify-from-stdin)
            - [Look up the unicode emoji for a (GitHub) name](#look-up-the-unicode-emoji-for-a-github-name)
            - [Look up the (GitHub) name for an emoji](#look-up-the-github-name-for-an-emoji)

<!-- markdown-toc end -->

**NOTE**: Emojitsu currently only supports name <-> unicode conversions for emoji
supported by GitHub. But there is no reason it should stay so confined, if we
find we need other features.

## Installation

Using [opam](https://opam.ocaml.org/doc/Install.html):

<!-- $MDX skip -->
```sh
$ opam pin https://github.com/shonfeder/emojitsu.git#0.0.2
```

For Linux with x86 architecture, there is also a portable executable in the
[releases](https://github.com/shonfeder/emojitsu/releases). This is intended for
use in CI.

## CLI Usage

### Overview

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

#### Emojify a file in place

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

#### Look up the unicode emoji for a (GitHub) name

```sh
$ emojitsu find-unicode black_flag
🏴
```

#### Look up the (GitHub) name for an emoji

```sh
$ emojitsu find-name ☮
peace_symbol
```
