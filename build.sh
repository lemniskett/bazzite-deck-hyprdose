#!/bin/bash

RELEASE="$(rpm -E %fedora)"
WVKBD_VERSION="v0.16"

set -ouex pipefail

enable_copr() {
    repo="$1"
    repo_with_dash="${repo/\//-}"
    wget "https://copr.fedorainfracloud.org/coprs/${repo}/repo/fedora-${RELEASE}/${repo_with_dash}-fedora-${RELEASE}.repo" \
        -O "/etc/yum.repos.d/_copr_${repo_with_dash}.repo"
}

dnf5 install -y --setopt=install_weak_deps=False \
    wayland-devel \
    libxkbcommon-devel \
    pango-devel \
    scdoc

git clone https://github.com/jjsullivan5196/wvkbd.git /tmp/wvkbd
cd /tmp/wvkbd
git checkout "$WVKBD_VERSION"
make PREFIX=/usr
make PREFIX=/usr install
cd /
rm -rf /tmp/wvkbd

dnf5 remove -y \
    wayland-devel \
    libxkbcommon-devel \
    pango-devel \
    scdoc

enable_copr "solopasha/hyprland"
enable_copr "atim/starship"

dnf5 install -y --setopt=install_weak_deps=False \
    xdg-desktop-portal-hyprland \
    hyprland \
    hyprpaper \
    hyprland-qtutils \
    hyprpolkitagent \
    swayidle \
    foot \
    waybar \
    nwg-drawer \
    wdisplays \
    mako \
    wob \
    grim \
    slurp \
    calcurse \
    stow \
    brightnessctl \
    alacarte \
    seahorse \
    NetworkManager-tui \
    gnome-extensions-app \
    papirus-icon-theme \
    adw-gtk3-theme \
    starship \
    htop
