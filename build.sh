#!/bin/bash

RELEASE="$(rpm -E %fedora)"
WVKBD_VERSION="v0.16"
OPENSD_VERSION="v0.52"

set -ouex pipefail

enable_copr() {
    repo="$1"
    repo_with_dash="${repo/\//-}"
    wget "https://copr.fedorainfracloud.org/coprs/${repo}/repo/fedora-${RELEASE}/${repo_with_dash}-fedora-${RELEASE}.repo" \
        -O "/etc/yum.repos.d/_copr_${repo_with_dash}.repo"
}

dnf5 install -y --setopt=install_weak_deps=False \
    gcc-c++ \
    cmake \
    meson \
    ninja-build \
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
wvkbd-mobintl --version
rm -rf /tmp/wvkbd

git clone https://codeberg.org/OpenSD/opensd.git /tmp/opensd
cd /tmp/opensd
git checkout "$OPENSD_VERSION"
cmake -Bbuild -DOPT_POSTINSTALL=FALSE -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr
cmake --build build
cd build
cmake --build . --target install
cd /
opensdd --version
rm -rf /tmp/opensd

wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -C magenta

# Keep.build deps for now, might be needed for hyprpm
# dnf5 remove -y \
#     gcc-c++ \
#     cmake \
#     wayland-devel \
#     libxkbcommon-devel \
#     pango-devel \
#     scdoc

enable_copr "solopasha/hyprland"
enable_copr "atim/starship"

dnf5 install -y --setopt=install_weak_deps=False \
    xdg-desktop-portal-hyprland \
    hyprland \
    hyprpaper \
    hyprland-qtutils \
    hyprpolkitagent \
    swayidle \
    eww-git \
    foot \
    waybar \
    nwg-drawer \
    wdisplays \
    pavucontrol \
    mako \
    wob \
    grim \
    slurp \
    calcurse \
    stow \
    brightnessctl \
    alacarte \
    seahorse \
    eog \
    NetworkManager-tui \
    gnome-extensions-app \
    papirus-icon-theme \
    adw-gtk3-theme \
    starship \
    htop
