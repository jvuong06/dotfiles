## Installation Instructions
If your file system is encrypted it may be useful to copy your theme to the boot directory. If not, you can simply use the path to your theme.
### Copy the theme to your GRUB theme directory
```
$ cp -r /path/to/theme /boot/grub/themes/
```
### Add your theme to /etc/default/grub
```
GRUB_THEME="/boot/grub/themes/your_theme/theme.txt"
```
### Update your GRUB config
```
$ grub-mkconfig -o /boot/grub/grub.cfg
```
