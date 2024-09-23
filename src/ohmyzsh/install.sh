#!/bin/bash

set -e


install_software() {
    if [ -z "$1" ]; then
        echo "请提供要安装的软件包名称"
        return 1
    fi

    SOFTWARE_NAME="$1"

    # 检测发行版并安装软件
    if command -v apt &> /dev/null; then
        # Debian/Ubuntu
         apt update
         apt install -y "$SOFTWARE_NAME"

    elif command -v dnf &> /dev/null; then
        # Fedora
         dnf install -y "$SOFTWARE_NAME"

    elif command -v pacman &> /dev/null; then
        # Arch Linux
         pacman -Sy --noconfirm "$SOFTWARE_NAME"

    else
        echo "不支持的发行版或未找到合适的包管理器"
        return 1
    fi
    hash -r
    echo "$SOFTWARE_NAME 安装依赖完成"
}

install_software curl zsh git 
if [ ! "$(command -v zsh)" ]; then
     echo "not install  zsh !"
fi

if [ ! -d "{HOME}/.oh-my-zsh" ]; then
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


if [ -z "${ZSH_CUSTOM}" ]; then
    ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"
fi

if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
     echo "install zsh-syntax-highlighting"
     git clone https://github.com/zsh-users/zsh-syntax-highlighting.git  ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
fi

if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
     echo "zsh-autosuggestions"
     git clone https://github.com/zsh-users/zsh-autosuggestions.git  ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
fi
PLUGINS=(vi-mode zsh-syntax-highlighting zsh-autosuggestions)
for plugin in "${PLUGINS[@]}"; do
    if ! grep -q "$plugin" ~/.zshrc; then
        sed -i "/^plugins=(/ s/)/ $plugin)/" ~/.zshrc
    fi
done

if ! grep -q "VI_MODE_SET_CURSOR" ~/.zshrc; then
cat <<EOM >> ~/.zshrc
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
bindkey -v
bindkey -M viins jj vi-cmd-mode
EOM
fi


