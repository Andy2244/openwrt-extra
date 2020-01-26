## Openwrt extra package feed.

### Description

This is an [OpenWrt](https://openwrt.org/) package feed containing [**Samba 4.11.x**](https://www.samba.org/), [**SoftetherVPN 5.x (dev/git)**](https://github.com/SoftEtherVPN/SoftEtherVPN) and [**Ksmbd**](https://github.com/cifsd-team/ksmbd) servers.

#### Ksmbd
The 'ksmbd-server' package is a tiny (200kb) samba4 alternative, if all you want is a smb2/3 compatible fileserver.

#### Download/ipks
Ready build ipk's for *Snapshots* based firmware, can be downloaded from here: [snapshots/packages](https://downloads.openwrt.org/snapshots/packages/).

#### Note
Samba [VFS modules](https://wiki.samba.org/index.php/Virtual_File_System_Modules) are supported and can be added via luci.

The size of the Samba4-server/libs.ipk and deps are around 8 MB, so you need a >8MB NVRAM device to fit the final image or setup a [ext-root](https://openwrt.org/docs/guide-user/additional-software/extroot_configuration) *(recommend for ad-dc operation)*.

The package includes untested options for: **[ad-dc](https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller)** *(Needs manual setup via 'samba-tool' to create a custom smb.conf)*.

### Usage

#### Basic
You can use the [openwrt-package-builder](https://github.com/Andy2244/openwrt-package-builder), which will setup/build the packages and allows for local hosting as well.

Create/edit those lines in the \*.txt file to the desired packages.

*Samba4*
```
FEED_1="src-git extra https://github.com/Andy2244/openwrt-extra.git"
FEED_1_PACKAGES="samba4-server luci-app-samba4 wsdd2"
```

*Ksmbd*
```
FEED_1="src-git extra https://github.com/Andy2244/openwrt-extra.git"
FEED_1_PACKAGES="ksmbd-server luci-app-ksmbd wsdd2"
```
*NOTE: Consist of a 'ksmbd.ko' kernel module and the 'usmbd' userspace binary.*

*Softether5*
```
FEED_1="src-git extra https://github.com/Andy2244/openwrt-extra.git"
FEED_1_PACKAGES="softethervpn5-server"
```
#### Advanced (already setup OpenWrt sdk)
To use these packages, add the following line to your ```feeds.conf``` or ```feeds.conf.default``` in the OpenWrt buildroot:

```src-git extra https://github.com/Andy2244/openwrt-extra.git```

Than include and install all packages from your ```feeds.conf```, while ensuring all extra packages are prefered via:
```
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds uninstall -a
./scripts/feeds install -f -p extra -a
./scripts/feeds install -a
```
Make sure the install line notes the extra feed and afterwards run:
```make menuconfig``` or ```make defconfig``` to expand, create the ```.config```

The packages should appear under **Network->Samba4**, **Network->VPN->softethervpn5-server** and **Network->Filesystem->smbd-server**.

### Problems

#### Visibility (share names are not visible)
If you cant see your share in the Windows 10 explorer, make sure the ```wsdd2``` package is installed and enabled.

**On Windows 10** check those services: 
* Start the ```Function Discovery Provider Host``` and ```Function Discovery Resource Publication``` services, and then set them to Automatic (Delayed Start).
* When you open Explorer Network, enable network discovery when you are prompted.

**On Linux/macOS** make sure the ```avahi-dbus-daemon``` package is installed and enabled.

#### Share invalid user access
If you encounter invalid user access errors, try enabling the ```Force Root``` option. This will ignore the ```Allowed users``` and force access rights via the root user.

#### CPU problems
The process priority/niceness can be set in the config and may avoid samba stalling other processes on low end devices.
```
config procd 'extra'
	option samba_nice '3'
 ```

#### Compatible Filesystems
You should use a native linux filesystem with samba4/smbd, like btrfs, ext2/3/4 or F2FS (ssd/flash drives). The NTFS driver in openWRT is readonly for none-root useres, so will not work correctly, you can instead use exFAT (enable _build patented_ in menuconfig) if you need a Windows compatible FS. You can format a drive to ext2/3/4 on Windows via [partitionwizard-portable](https://www.partitionwizard.com/download/v11.6-portable/11x64.zip).
