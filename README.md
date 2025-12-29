# Linux install from "scratch" using archinstall

## Firewall UFW

> sudo pacman -S ufw

Enable and start service:

> sudo systemctl enable ufw

> sudo systemctl start ufw

Enable ufw:

> sudo ufw enable

Default rules should be fine:

> sudo ufw status verbose

Simple rules to  set if needed:

> sudo ufw default deny incoming

> sudo ufw default allow outgoing

## Updating Arch

> sudo pacman -Syu

## Creating Symlinks

Use symlinks to create a central location for configs.

> ln -s [target] [location]

Verifying a symlink:

> ln -l [location-path]

## Screen Brightness

Use brightnessctl:

> sudo pacman -S brightnessctl

Brightness keys should now work on Sway on the Macbook Pro 14,1. Following lines are in the default config:

> bindsym --locked XF86MonBrightnessDown exec brightnessctl set 5%-

> bindsym --locked XF86MonBrightnessUp exec brightnessctl set 5%+

Or in console:

> brightnessctl set 30%

## Keyboard Backlight

On the Macbook Pro 14,1 the backlight is exposed by spi::kbd_backlight:

> cat /sys/class/leds/spi::kbd_backlight/max_brightness

> echo 30 | sudo tee /sys/class/leds/spi::kbd_backlight/brightness

brightnessctl can be used:

> brightnessctl -d spi::kbd_backlight set 50%

These lines can be added to the Sway config file:

> bindsym XF86KbdBrightnessUp exec brightnessctl -d spi::kbd_backlight set +10%

> bindsym XF86KbdBrightnessDown exec brightnessctl -d spi::kbd_backlight set 10%-

## Sound

According to ChatGPT, here is a model of how sound works in linux

### The mental model

Think of Linux audio in layers:

**Kernel driver** – talks to the actual sound chip
→ this is snd_hda_intel (already in the kernel)

**Low-level audio system** – exposes sound devices to userspace
→ ALSA

**Audio server** – manages volumes, mixing, Bluetooth, apps, etc
→ PipeWire (modern replacement for PulseAudio + JACK)

**Session manager** – tells PipeWire what to do automatically
→ WirePlumber

**You do not pick one. They stack together.**

### What you actually need (minimal, sane setup)

You want:

- ALSA (base layer)
- PipeWire (audio server)
- WirePlumber (auto-config)

**Nothing else.** (Narrator: "They did in fact need something else.")

Install:

> sudo pacman -S alsa-utils pipewire pipewire-alsa pipewire-pulse wireplumber

Explanation:

- alsa-utils - Gives you tools like alsamixer to unmute the card (very important)
- pipewire - The actual audio engine
- pipewire-alsa - Makes ALSA apps route audio into PipeWire
- pipewire-pulse - Makes PulseAudio apps work without PulseAudio installed
- wireplumber - Auto-detects devices, creates outputs, remembers volumes (without this, PipeWire feels “dead”)

Enable pipewire user service:

> systemctl --user enable --now pipewire pipewire-pulse wireplumber

As well as the above, we need some Mac specific drivers. These need to be recompiled after a kernal update:
- https://github.com/davidjo/snd_hda_macbookpro (currently using)
- https://github.com/egorenar/snd-hda-codec-cs8409 (previously worked until broken by a kernal update)

Mute / unmute / volume control:

> alsamixer

Use F6 to select device, and F5 for extended options.

Verifies audio devices exist:

> aplay -l

Check pipewire sees sinks:

> pactl list short sinks

Test sound:

> speaker-test -c 2

## System Fan

Use mbpfan:

> yay -S mbpfan-git

Start mbpfan as a systemd service:

> sudo systemctl enable mbpfan.service

> sudo systemctl daemon-reload

> sudo systemctl start mbpfan.service

## Fonts

Font Awesome is needed for Waybar by default.

> sudo pacman -S otf-font-awesome

Update font cache:

> fc-cache -fv

Find fonts:

> fc-list | grep -i xyz

Fonts installed:
- otf-font-awesome
- ttf-roboto-mono-nerd
- ttf-roboto-mono

## SSH for github

Generate a key:

> ssh-keygen -t ed25519 -C "github"

Start SSH agent (fish shell compatable command):

> eval (ssh-agent -c)

Load key in to agent:

> ssh-add ~/.ssh/id_ed25519

Copy the key and add to github in SSH and GPG Keys section:

> cat ~/.ssh/id_ed25519.pub

Enter user details before first commit:

> git config --global user.name "Your Name"

> git config --global user.email "you@example.com"

Steps for an initial commit:

> git init

> git add .

> git commit -m "initial backup"

> git branch -M main

> git remote add origin git@github.com:YOUR_USERNAME/YOUR_REPO.git

> git push -f origin main

Usual workflow for committing changes:

> git add .

> git commit -m "describe what changed"

> git push origin main

