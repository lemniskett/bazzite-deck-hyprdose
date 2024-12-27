# Bazzite Deck Hyprdose

Based on bazzite-deck-gnome:testing, this image is used for my Steam Deck rice, mainly Hyprland stuffs. Despite that, The GNOME components still exists.

I prefer not to touch existing scripts that made the Gaming mode and Desktop mode possible, So I made a daemon that can stops SDDM and switches to TTY that logs in automatically to Hyprland.

## Using

```sh
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/lemniskett/bazzite-deck-hyprdose:latest
```