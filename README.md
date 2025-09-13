# linux-install
My notes for an Arch Linux install and the dot files

# video notes

~ $ lspci -k | grep -A3 -i vga
00:02.0 VGA compatible controller: Intel Corporation Iris Plus Graphics 640 (rev 06)
	Subsystem: Apple Inc. Device 0174
	Kernel driver in use: i915
	Kernel modules: i915

~ $ lsmod | grep i915
i915                 4804608  26
i2c_algo_bit           24576  1 i915
drm_buddy              28672  1 i915
ttm                   118784  1 i915
intel_gtt              28672  1 i915
drm_display_helper    278528  1 i915
cec                    94208  2 drm_display_helper,i915
video                  81920  1 i915

~ $ pacman -Q | grep -E 'mesa|vulkan|intel|wayland'
hyprwayland-scanner 0.4.5-1
intel-gmmlib 22.8.1-1
intel-media-driver 25.2.6-1
intel-ucode 20250812-1
libva-intel-driver 2.4.1-5
linux-firmware-intel 20250808-1
mesa 1:25.2.1-2
qt5-wayland 5.15.17+kde+r57-1
qt6-wayland 6.9.1-1
vulkan-icd-loader 1.4.321.0-1
vulkan-intel 1:25.2.1-2
vulkan-nouveau 1:25.2.1-2
vulkan-radeon 1:25.2.1-2
wayland 1.24.0-1
wayland-protocols 1.45-1
xorg-xwayland 24.1.8-1

# sound notes

sudo pacman -Syu
sudo pacman -S base-devel linux linux-headers linux-firmware sof-firmware alsa-utils alsa-ucm-conf pipewire pipewire-alsa pipewire-pulse wireplumber pavucontrol

CS8409 driver needs to be rebuilt after every kernal update.

git clone https://github.com/egorenar/snd-hda-codec-cs8409.git
cd snd-hda-codec-cs8409

make clean
make
sudo make install
sudo depmod -a

modinfo snd-hda-codec_cs8409
aplay -l
wpctl status
