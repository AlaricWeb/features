#!/bin/bash
set -e 
# 检测系统的包管理器并返回名称
detect_package_manager() {
    if command -v apt-get >/dev/null 2>&1; then
        echo "apt-get"
    elif command -v apk >/dev/null 2>&1; then
        echo "apk"
    elif command -v yum >/dev/null 2>&1; then
        echo "yum"
    elif command -v dnf >/dev/null 2>&1; then
        echo "dnf"
    elif command -v pacman >/dev/null 2>&1; then
        echo "pacman"
    else
        echo "No known package manager found."
        exit 1
    fi
}
# 安装软件包
install_packages() {
    package_manager=$(detect_package_manager)
    
    # 获取要安装的软件包名称
    packages="$@"
    
    case "$package_manager" in
        apt-get)
            echo "Using apt-get to install packages."
             apt-get update
             apt-get install -y $packages
            ;;
        apk)
            echo "Using apk to install packages."
             apk update
             apk add $packages
            ;;
        yum)
            echo "Using yum to install packages."
             yum install -y $packages
            ;;
        dnf)
            echo "Using dnf to install packages."
             dnf install -y $packages
            ;;
        pacman)
            echo "Using pacman to install packages."
             pacman -Syu --noconfirm $packages
            ;;
        *)
            echo "Unsupported package manager."
            exit 1
            ;;
    esac
}


install_packages curl unzip ;


curl -fsSL https://fnm.vercel.app/install | bash



if [ "$(command -v fnm)" ]; then
    echo "command \"fnm\" exists on system"
    fnm install  $NODE_VERSION
fi
