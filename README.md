# Restoring dotfiles

> [!IMPORTANT]
> This guide assumes you are doing this on a fresh install.
> It will not preserve any preexisting dotfiles!

This guide was written using information from the [arch wiki.](https://wiki.archlinux.org/title/Dotfiles)

# Prerequisites

Ensure git, vim, and bash are installed.
Wait to install zsh after running this script.

# Clone the Repo

```bash
git clone --bare https://github.com/dvrlabs/archdots $HOME/.dotfiles
```

# Edit ~/.bashrc

Add the below alias to your .bashrc so we can run commands with it.

```bash
alias dots='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
```

Now restart your terminal/shell. Or:
```bash
source .bashrc
```

# Move the config files into your system 

```bash
dots checkout -f
```

# Make sure that by default all changes are untracked

```bash
dots config --local status.showUntrackedFiles no
```

# Install submodules
```bash
dots submodule update --init
```

# Removing README.md (this file)

1. Change to home
```bash
cd
```
2. skip-worktree for README.md
```bash
dots update-index --skip-worktree README.md
```

3. Remove the file
```bash
\rm README.md
```

4. Ensure dotfiles doesn't care
```bash
dots status
```

# Done!

You should now be able to manage your dotfiles with the ```dots``` alias as though it were git.

