#!/bin/bash

# Post-install script for Fedora based distros

#update system
sudo dnf update -qq

#install programes
sudo dnf install corectrl micro neovim neofetch gnome-tweaks google-chrome-unstable firefox steam kitty discord krita calibre -yy

#install flatpak
sudo dnf install flatpak -yy

#add flatpak to repos and install flatpaks
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub net.davidotek.pupgui2 com.mattjakeman.ExtensionManager -yy

#make autostart folder
mkdir ~/.config/autostart

#system tweaks
sudo echo "vm.swappiness = 10" >> /etc/sysctl.conf


#setup corectrl
cp /usr/share/applications/org.corectrl.corectrl.desktop ~/.config/autostart/org.corectrl.corectrl.desktop
sudo touch /etc/polkit-1/rules.d/90-corectrl.rules
sudo echo "polkit.addRule(function(action, subject) {
    if ((action.id == "org.corectrl.helper.init" ||
         action.id == "org.corectrl.helperkiller.init") &&
        subject.local == true &&
        subject.active == true &&
        subject.isInGroup("rob")) {
            return polkit.Result.YES;
    }
});" >> /etc/polkit-1/rules.d/90-corectrl.rules

echo "add amdgpu.ppfeaturemask=0xffffffff mitigations=off to kernel options"
echo "grub-mkconfig -o /boot/grub/grub.cfg"
