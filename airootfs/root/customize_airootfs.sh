#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
sed -i 's/#\(zh_CN\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ln -sf /etc/fonts/conf.avail/70-noto-cjk.conf /etc/fonts/conf.d

usermod -s /usr/bin/fish root
echo 'root:root' | chpasswd
chmod 700 /root
fish -c "fish_update_completions"

useradd -s /usr/bin/fish -G wheel -m archlive
echo 'archlive:archlive' | chpasswd
chown -R archlive:archlive /etc/skel
cp -aT /etc/skel/ /home/archlive/
runuser -l archlive -c 'fish -c "fish_update_completions"'

sed -i '/ALL=(ALL) NOPASSWD: ALL/s/^# //' /etc/sudoers

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i "s/#Server/Server/g" /etc/pacman.d/archlinuxcn-mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

systemctl enable pacman-init.service choose-mirror.service sddm.service NetworkManager.service bluetooth.service
systemctl set-default graphical.target
timedatectl set-ntp true
