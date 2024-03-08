# Installation Quickie

`setfont ter-132b`

`timedatectl`

partition w/ fdisk

mount new fs + swapon

`curl https://archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4 > /etc/pacman.d/mirrorlist`

`pacstrap -K /mnt base base-devel linux linux-firmware`

## In case of errors:

```
rm -rf /etc/pacman.d/gnupg
pacman-key --init
pacman-key --populate archlinux
pacman-key --refresh-keys
```

`genfstab -U /mnt >> /mnt/etc/fstab`

`arch-chroot /mnt`

`ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime`

`hwclock --systohc`

edit `/etc/locale.gen` and uncomment `en_US.UTF-8 UTF-8`

`locale-gen`

`echo "LANG=en_US.UTF-8" > /etc/locale.conf`

`echo "hostname" > /etc/hostname`

`passwd`

# Install More Packages!

`pacman -S acl alsa-lib alsa-plugins alsa-topology-conf alsa-ucm-conf alsa-utils amd-ucode archlinux-keyring attr audit automake bat bind binutils cmake coreutils curl diffutils eza fd feh findutils firefox fzf gawk git grep gzip htop i3-wm i3blocks less lm_sensors lua-language-server maim make man-db man-pages ncurses networkmanager ninja npm nsxiv pavucontrol perl picom pulseaudio pulseaudio-alsa pulseaudio-jack python python-pip python-pipx reflector ripgrep rofi rofi-calc rofi-emoji rofimoji sof-firmware sshfs systemd systemd-libs systemd-resolvconf tar unzip usb_modeswitch util-linux util-linux-libs vim which xclip xdg-utils xorg-fonts-encodings xorg-server xorg-server-common xorg-setxkbmap xorg-xauth xorg-xinit xorg-xkbcomp xorg-xmodmap xorg-xprop xorg-xrandr xorg-xrdb xorg-xset xterm zsh`
