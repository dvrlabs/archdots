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
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
```

Now restart your terminal/shell. Or:
```bash
source .bashrc
```

# Move the config files into your system 

```bash
dotfiles checkout -f
```

# Make sure that by default all changes are untracked

```bash
dotfiles config --local status.showUntrackedFiles no
```

# Install submodules
```bash
dotfiles submodule update --init
```

# Removing README.md (this file)

1. Change to home
```bash
cd
```
2. skip-worktree for README.md
```bash
dotfiles update-index --skip-worktree README.md
```

3. Remove the file
```bash
\rm README.md
```

4. Ensure dotfiles doesn't care
```bash
dotfiles status
```

# Done!

You should now be able to manage your dotfiles with the ```dotfiles``` alias as though it were git.

