# .dotfiles (Arch Linux Laptop)

The term "dotfiles" refers to a user's personal configurations to various programs they have running on their system. These configurations respectively are for Arch Linux on my laptop.

## Table of Contents

- [.dotfiles (Arch Linux Laptop)](#dotfiles-arch-linux-laptop)
  - [Initial Setup](#initial-setup)
  - [Installing/Uninstalling Configs](#installinguninstalling-configs)
  - [Packages](#packages)

---

## Initial Setup

This installation method intelligently makes use of [GNU Stow](https://www.gnu.org/software/stow/), which is required for installation. If you do not already have this package, install it.

> **Note:** If you're not already familiar with stow, I highly recommend learning how to make use of it on Unix-like systems whether you're a professional or a power user.

```bash
pacman -S stow
```

You will also need Git.

```bash
pacman -S git
```

Clone this repo into your `$HOME` directory using SSH and `cd` into it.

```bash
git clone git@github.com:shawnkhoffman/.dotfiles-arch-laptop.git
cd .dotfiles-arch-laptop
```

Then initialize the git submodules from within the root of the repo.

```bash
git submodule update --init --recursive
```

## Installing/Uninstalling Configs

Installing/uninstalling is a very straightforward process; simply execute the [installer.sh](/installer.sh) script and follow the instructions at the prompt.

---

## Packages

The [/packages](/packages) directory contains two lists of all the packages that I use on my Arch Linux laptop.

> **WARNING:** These packages have been tested on the [HP Spectre x360 15-eb0xxx](https://obishawnkenobi.dev/2022/08/14/arch-linux-on-a-laptop/). Furthermore, there are many system configuration packages listed here that are not recommended for all systems and, therefore, installing one or more of them could cause issues with your current configuration. **Before installing all of the packages in these lists, be sure to go through both of them and remove the packages that are not right for your system.**

This assumes you use both pacman for official packages and yay for AUR packages. Install packages from pacman and AUR:

```bash
cd packages/
pacman -S --noconfirm --needed - < .pacman.list && yay -S --noconfirm - < .aur.list
```

> Note: The `--needed` option skips packages that are already installed.

To create a package list of your own, run the following commands.

```bash
pacman -Qqe > .pacman.list
```

```bash
yay -Qqe > .aur.list
```
