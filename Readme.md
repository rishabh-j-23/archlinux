# dev Script

A simple bash utility to manage **reload**, **config**, and **install** actions for your development environment.

---

## Features

- Reload custom scripts for various packages.
- Manage package configuration by copying from repo to `$HOME/.config`.
- Install packages via custom install scripts.
- Supports **dry-run** mode to preview actions without executing.

---
## Init

```bash
DEV_CONFIG=~/sources/archlinux
mkdir -p $DEV_CONFIG
git clone git@github.com:rishabh-j-23/archlinux.git $DEV_CONFIG
```

---

## Usage

```bash
./dev [--dry-run] <action> <package>
````

### Actions

| Action  | Description                                                  |
| ------- | ------------------------------------------------------------ |
| reload  | Run a reload script located in `./reload/<package>.sh`       |
| configs | Copy configs from `./configs/<package>/` to `$HOME/.config/` |
| install | Run an install script located in `./packages/<package>.sh`   |

---

## Examples

Reload the `hypr` package:

```bash
./dev reload hypr
```

Copy config files for `kitty` package:

```bash
./dev configs alacritty
```

Install the `neofetch` package:

```bash
./dev install alacritty
```

Dry-run example (no changes made, just preview commands):

```bash
./dev --dry-run configs hypr
```

---

## How it works

* The script looks for scripts or config folders inside the repository relative to where it’s run.
* `reload` and `install` execute respective shell scripts.
* `configs` deletes existing config directory and copies fresh config files.
* The optional `--dry-run` flag prints commands instead of executing them.
