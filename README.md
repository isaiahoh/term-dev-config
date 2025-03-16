# term-dev-config

This repository contains the configuration files for my terminal development environment. Includes:

- Installation instructions for Ubuntu
- Configuration files for:
  - Neovim
  - OhMyPosh
  - tmux

## Setup

### Getting Newest CMake

Following the Instructions from [here](https://apt.kitware.com/)

### Getting Newest Ninja Build

Install Ninja Build from the github releases page [here](https://github.com/ninja-build/ninja/releases)

Move the binary to `/usr/bin/` to make it available globally

```bash
sudo mv ninja /usr/bin/
```

### Getting LLVM Tools

Follow the Instructions from [here](https://apt.llvm.org/)

### Get VCPKG

Follow the Instructions from [here](https://learn.microsoft.com/en-us/vcpkg/get_started/get-started?pivots=shell-bash)

### Install Newest Neovim

```bash
git clone https://github.com/neovim/neovim
cd neovim
make cmake_build_type=release cmake_extra_flags="-dcmake_install_prefix=$home/neovim"
make install
```

then add to `.bashrc`:

```bash
export PATH=$HOME/neovim/bin:$PATH
```

then run `source ~/.bashrc`

### Install NodeJS

Follow the Instructions from [here](https://github.com/nodesource/distributions)

## Clone This Repository

```bash
git clone https://github.com/isaiahoh/term-dev-config.git ~/.config
```

### Install Python3 and Venv

```bash
sudo apt install python3 python3-venv
```

### Install OhMyPosh

```bash
curl -s https://ohmyposh.dev/install.sh | bash -s
```

add to `.bashrc`:

```bash
export PATH=$PATH:/home/isaiahoh/.local/bin
```

and at the end of `.bashrc` add:

```bash
eval "$(oh-my-posh init bash --config ~/.config/ohmyposh/zen.toml)"
```

then run `source ~/.bashrc`

### Install Tmux Plugin Manager

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

tmux
tmux source ~/.config/tmux/tmux.conf
```

then press `prefix` + `I` to install the plugins

- the prefix I have set is `Ctrl + space`

### Set LLVM apt-alternatives

```bash
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-<version> 100
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-<version> 100
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-<version> 100
```

### Install Cppcheck

```bash
sudo apt install cppcheck
```

### Install Neovim Plugins

I use Mason, so Install the plugins you need with `:MasonInstall`
here are the plugins I use:

- bash-language-server
- cmake-language-server
- cmakelang
- codelldb
- lua-language-server
- marksman
- prettier
- python-language-server
- stylua
- taplo

### Install python-language-server plugins for Neovim

```bash
source ~/.local/share/nvim/mason/packages/python-lsp-server/venv/bin/activate
pip3 install --upgrade pip
pip3 install pylsp-mypy
pip3 install python-lsp-isort
pip3 install python-lsp-black
pip3 install python-lsp-ruff
deactivate
```
