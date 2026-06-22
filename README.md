# My Dotfiles

These are my dotfiles, i.e. configurations for all sorts of stuff. They are
mainly here for my own usage, so if you want to use them I recommend you fork
this repo instead of cloning it directly, as anything here might change at any
time.

## Repository Structure

The individual directories of this repository all contain configurations for
either a single piece of software, or for a bundle of related applications. They
are intended to be modular and to depend upon each other as little as possible.

## Note on Terminology

* *link*: Links here always stand for *symbolic* links. The same goes for
  derived words like *linking*, etc.

* *module*: With modules, the individual configuration directories are meant.

* *linking a module*: Linking a module means linking all files of the module
  directory into the filesystem.

* *unlinking a module*: Unlinking a module means removing its links from the
  filesystem.

## (Un-)Linking Procedure

When linking or unlinking a module, the following happens:

Say we are working with a `module_a`, whose root we have configured to be
`/fs/modules/a` (via `.state.zsh`, see [Module Structure](#module-structure)).

Now, when linking, a file with relative path `module_a/files/file` will produce
a symlink `/fs/modules/a/files/file` pointing back to it. Any directory on that
path which does not exist yet will be created.

When unlinking, on the other hand, if there exists some file
`module_a/files/file` within the module, then any file that is a link (link as
defined by the `-h` unary conditional operator of ZSH) at
`/fs/modules/a/files/file` will be deleted. Any directory on that path which is
left empty after the deletion of the link will also be removed.

Duly note, however, that this process will *never* create links to directories.
It traverses modules recursively and only operates upon regular files (*regular
file* being defined by the `-f` unary conditional operator of ZSH).

## Module Structure

### Overview

The individual modules, in addition to the regular files that should be linked
as described [above](#un-linking-procedure), contains three additional files,
which will not be linked, in its root directory.:

| File         | Description                     |
|---           |---                              |
| `.state.zsh` | [State File](#state-file)       |
| `README.txt` | [Documentation](#documentation) |

### State File

The file `.state.zsh` shall set two shell variables:

* `MOD_ROOT`: The absolute path of the module root (this should be set
  manually).
* `MOD_LINKED`: `1` if the module is currently linked, anything else otherwise
  (this should be set manually only for debugging/recovery purposes).

### Documentation

The file `README.txt` shall contain documentation regarding the module. The
contents of this file will be displayed after a successful link operation.
