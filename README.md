## Openwrt extra package feed.

### Description

This is an [OpenWrt](https://openwrt.org/) package feed containing [**Samba 4.8.x**](https://www.samba.org/) and [**SoftetherVPN 5.x (dev/git)**](https://github.com/SoftEtherVPN/SoftEtherVPN) servers.

### Update (Aug 2018)

Samba 4, wsdd2, luci-app-samba4 was merged into package/master, so this feeds will contain unmerged or test changes from now on.\
Ready build ipk's for the Snapshot SDK, can be downloaded from here: [snapshots/packages](https://downloads.openwrt.org/snapshots/packages/).

#### Note
Samba [VFS modules](https://wiki.samba.org/index.php/Virtual_File_System_Modules) are supported and can be added via luci.\
The package includes experimental support for: **[ad-dc](https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller), [winbind](https://wiki.samba.org/index.php/Configuring_Winbindd_on_a_Samba_AD_DC), avahi, quota, acl** *(no cluster, printer,cups/iprint support)*

The size of the Samba4-server/libs.ipk and deps are around 5.8 MB, so you need a >8MB NVRAM device to fit the final image or setup a [ext-root](https://openwrt.org/docs/guide-user/additional-software/extroot_configuration) *(recommend for ad-dc operation)*.

### Usage

#### Basic
You can use the [openwrt-package-builder](https://github.com/Andy2244/openwrt-package-builder), which will setup/build the packages and allows for local hosting as well.

Create/edit those lines in the \*.txt file to the desired packages.

*Samba4*
```
FEED_1="src-git extra https://github.com/Andy2244/openwrt-extra.git"
FEED_1_PACKAGES="samba4-server luci-app-samba4 wsdd2"
```

*Softether*
```
FEED_1="src-git extra https://github.com/Andy2244/openwrt-extra.git"
FEED_1_PACKAGES="softethervpn-server ncurses"
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

The packages should appear under **Network->Samba4** and **Network->VPN->softethervpn-server**. There is also a updated **Samba4 luci app** package, you should select.

### Problems

#### Visibility (share names are not visible)
If you cant see your share in the Windows 10 explorer as a workgroup user, make sure the ```wsdd2``` package is installed and enabled.

**On Windows 10** check those services: 
* Start the ```Function Discovery Provider Host``` and ```Function Discovery Resource Publication``` services, and then set them to Automatic (Delayed Start).
* When you open Explorer Network, enable network discovery when you are prompted.

**On Linux/macOS** make sure the ```avahi-dbus-daemon``` package is installed and enabled.

#### Share invalid user access
If you encounter invalid user access errors, try enabling the ```Force Root``` option. This will ignore the ```Allowed users``` and force access rights via the root user.

#### CPU problems
If your firmware support's ```renice``` (busybox process tools option) than the init script will lower all samba related processes, which can help to avoid samba stalling other processes.
