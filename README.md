# Archlive

Arch Linux Live/Rescue CD with quality of life features, built with [Archiso](https://wiki.archlinux.org/index.php/Archiso).

![Screenshot](https://user-images.githubusercontent.com/44045911/75601974-bcdb4800-5afb-11ea-83b4-0ebc5abee2d8.png)

## Features

- **`releng` profile based**: familiar tools from official Arch Linux ISO
- **KDE Plasma powered**: say goodbye to daunting tty
- **Mainland China users oriented**: localized user interface, input method and multiple proxies
- **Useful GUI applications added**: system maintenance with ease
- **Powerful CLI utilities included**: supercharge your command line
- **Various optimizations**: TCP BBR, SysRq and many more

## Notes

- **Package list is opinionated. If your favorite program isn't included, or you think some packages are bloated, please create an issue/pull request with convincing reasons.**
- Default disk label is `ARCHLIVE`.
- Default user (`archlive`) is unprivileged as many services should not run as root.
- Default passwords are the same as usernames. `sudo` can be used without password.

## Customization

**Make any modification as root. Clone the repository with `sudo` is recommended.**

Please follow [the official wiki](https://wiki.archlinux.org/index.php/Archiso). If you only want to make changes to pre-installed packages, edit [`packages.x86_64`](packages.x86_64).

### Example: Remove Chinese goodies

Love the setup but not a Mainland China user? There is no patch file currently, but it's easy to manually remove them:

- Install [`archiso`](https://www.archlinux.org/packages/extra/any/archiso/) package
- Revert timezone to `/usr/share/zoneinfo/UTC` in [`/etc/localtime`](airootfs/root/customize_airootfs.sh#L9)
- Remove `zh_CN.UTF-8` from [`/etc/locale.gen`](airootfs/root/customize_airootfs.sh#L6)
- Revert locate to `en_US.UTF-8` in [`airootfs/etc/locale.conf`](airootfs/etc/locale.conf)
- Remove `fcitx5-chinese-addons-git`, `fcitx5-gtk-git` and `noto-fonts-cjk` in [`packages.x86_64`](packages.x86_64)
- Change `firefox-i18n-zh-cn` to `firefox-i18n-en-us` in [`packages.x86_64`](packages.x86_64)
- Remove [`airootfs/etc/skel/.config/fcitx5`](airootfs/etc/skel/.config/fcitx5)
- Run `./build.sh -v` as root

And you should be able to get what you want under `out`.
