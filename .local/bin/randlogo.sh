#!/bin/bash
distros=(AIX
         Alpine
         Anarchy
         Antergos
         "AOSC OS"
         "AOSC OS/Retro"
         Apricity
         ArcoLinux
         ArchBox
         ARCHlabs
         XFerience
         Arch
         Arya
         Bitrig
         BLAG
         BlueLight
         BSD
         Calculate
         CentOS
         ChaletOS
         Chrom
         ClearOS
         Clover
         Container_Linux
         Cucumber
         Deepin
         Devuan
         DragonFly
         Elementary
         Endless
         Exherbo
         Feren
         FreeMiNT
         Funtoo
         GalliumOS
         Gentoo
         Pentoo
         gNewSense
         GNOME
         GNU
         Grombyang
         Haiku
         Hyperbola
         IRIX
         Kali
         KDE_neon
         Kogaion
         KSLinux
         Kubuntu
         LEDE
         LFS
         Linux_Lite
         LMDE
         Lubuntu
         Lunar
         macos
         MagpieOS
         Manjaro
         Mer
         LinuxMint
         Namib
         NetBSD
         Nitrux
         NixOS
         Nurunner
         NuTyX
         OBRevenge
         OpenBSD
         openmamba
         OpenStage
         osmc
         OS
         PacBSD
         Pardus
         Parsix
         TrueOS
         PCLinuxOS
         Peppermint
         popos
         Porteus
         PostMarketOS
         Proxmox
         PureOS
         Radix
         Reborn_OS
         Redcore
         Refracted_Devuan
         Regata
         Rosa
         sabotage
         Sabayon
         Sailfish
         SalentOS
         SteamOS
         SunOS
         openSUSE_Leap
         openSUSE_Tumbleweed
         openSUSE
         SwagArch
         Tails
         Ubuntu-Budgie
         Ubuntu-GNOME
         Ubuntu-MATE
         Ubuntu-Studio
         Obarun
         windows10
         Windows7
         Xubuntu
         Zorin
         # old variants
         Arch_old
         Ubuntu_old
         Redhat_old
         Dragonfly_old
         # small variants
         Arcolinux_small
         Dragonfly_small
         Fedora_small
         Alpine_small
         Arch_small
         Ubuntu_small
         CRUX_small
         Debian_small
         Gentoo_small
         FreeBSD_small
         Mac_small
         NixOS_small
         OpenBSD_small
         android_small
         Antrix_small
         CentOS_small
         Cleanjaro_small
         ElementaryOS_small
         GUIX_small
         Hyperbola_small
         Manjaro_small
         MXLinux_small
         NetBSD_small
         Parabola_small
         POP_OS_small
         PureOS_small
         Slackware_small
         SunOS_small
         LinuxLite_small
         OpenSUSE_small
         Raspbian_small
         postmarketOS_small
         Void_small
)
echo -n "${distros[$(( $(date +%-s) % ${#distros[@]} ))]}"
