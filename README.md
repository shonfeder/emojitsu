# Emojitsu

_Tiny executable techniques for dealing with emoji_

![build](https://github.com/shonfeder/emojitsu/workflows/build/badge.svg)

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
    - [CI Usage](#ci-usage)
    - [Use with mdBook](#use-with-mdbook)

<!-- markdown-toc end -->

**NOTE**: Emojitsu currently only supports name <-> unicode conversions for emoji
supported by GitHub. But there is no reason it should stay so confined, if we
find we need other features.

## Installation

Using [opam](https://opam.ocaml.org/doc/Install.html):

<!-- $MDX skip -->
```sh
$ opam pin https://github.com/shonfeder/emojitsu.git#0.1.1
```

For Linux with x86 architecture, there is also a (hopefully) portable executable
in the [releases](https://github.com/shonfeder/emojitsu/releases). This is
intended for use in CI. See [CI Usage](#ci-usage) for details.

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

## CI Usage

You can use emojitsu in your CI pipeline by installing from source. likely using
opam.

We also build binaries via the ubuntu GitHub runner and upload them with our
releases. You can find the latest `gh-actions-emojitsu` binary in the
[releases][].

You can use it in your CI pipeline like so:

<!-- $MDX skip -->
```sh
# Install emojitsu
wget --no-verbose https://github.com/shonfeder/emojitsu/releases/download/0.1.1/gh-actions-emojitsu
chmod +x gh-actions-emojitsu

# Emojify the markdown
find . -type f -name "*.md" -exec ./gh-actions-emojitsu emojify -i {} \;
```

This has only been tested in other github runners any my own Think Pad running
Manjero.

## Use with mdBook

You can use _emojitsu_ as a preprocessor for [mdBook][] by wrapping it in with a
small bash script to account for mdBook's [idiosyncratic
expectations](https://github.com/rust-lang/mdBook/issues/1462).

In `./emojitsu-wrapper.sh`:

<!-- $MDX skip -->
```sh
#!/usr/bin/env bash
set -euo pipefail

jq -M -c .[1] <&0 | emojitsu emojify
```

_Explanation_ -- This script takes care of two thing:

1. It ignores the CLI args _mdBook_ passes to preprocessors to test for formatting
   support (which is not needed for _emojify_ to work its simple magic).
2. It extracts the second element of the JSON array _mdBook_ sends to `stdin`,
   which contains the book content.

After you've made the wrapper executable --

<!-- $MDX skip -->
```sh
chmod +x ./emojitsu-wrapper.sh
```

-- you can  use it in your _mdBook_ configuration by adding the following table
to the `book.toml`:

<!-- $MDX skip -->
```conf
# snip

[preprocessor.emojify]

command = "./emojitsu-wrapper.sh"
```

[mdBook]: https://github.com/rust-lang/mdBook
[releases]: https://github.com/shonfeder/emojitsu/releases
