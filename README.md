## Openwrt extra package feed.

### Description

This is an [OpenWrt](https://openwrt.org/) package feed containing [**Samba 4.8.x**](https://www.samba.org/) and [**SoftetherVPN 5.x (dev/git)**](https://github.com/SoftEtherVPN/SoftEtherVPN) servers.

### Update (Aug 2018)

Samba 4, wsdd2, luci-app-samba4 was merged into package/master, so this feeds will contain unmerged or test changes from now on.
_It should also build against the 18.06 release branch, if not open a issue here._

Snapshots can be downloaded from here: [snapshots/packages](https://downloads.openwrt.org/snapshots/packages/)

#### Note
Samba [VFS modules](https://wiki.samba.org/index.php/Virtual_File_System_Modules) are supported and can be added via luci.

The package includes experimental support for: **[ad-dc](https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller), [winbind](https://wiki.samba.org/index.php/Configuring_Winbindd_on_a_Samba_AD_DC), avahi, quota, acl** *(no cluster, printer,cups/iprint support)*

The size of the Samba4-server/libs.ipk and deps are around 5.8 MB, so you need a >8MB NVRAM device to fit the final image or setup a [ext-root](https://openwrt.org/docs/guide-user/additional-software/extroot_configuration) *(recommend for ad-dc operation)*.

### Usage
To use these packages, add the following line to your ```feeds.conf``` or ```feeds.conf.default``` in the OpenWrt buildroot:

```src-git extra https://github.com/Andy2244/openwrt-extra.git```

Than include and install all packages from your ```feeds.conf``` via:
```
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a
```
If build from master, uninstall and reinstall from extra feed, packages that already exists in the master feed:
```
./scripts/feeds uninstall samba4 luci-app-samba4 wsdd2
./scripts/feeds install -f -p extra samba4 luci-app-samba4 wsdd2
```
Make sure the install line notes the extra feed and afterwards run:
```make menuconfig``` or ```make defconfig``` to expand, create the ```.config```

The packages should appear under **Network->Samba4** and **Network->VPN->softethervpn-server**. There is also a updated **Samba4 luci app** package, you should select.


### smb.conf.example

The ```smb.conf.example``` file shows what options to uncomment in the ```smb.conf.template``` to get a easy share working, without any extra user setup, all new files/folders will be maped to "root".

### Problems

If you cant see your share in the Windows 10 (1709+) explorer as a workgroup user, thats because the default state in Windows 10 is now to uninstall the old smb1 protocol, along with the computer browser service, which was needed to display netbios shares in the explorer. Its not recommend to reinstall the old smb1 package, but following this [article](https://support.microsoft.com/en-nz/help/4034314/smbv1-is-not-installed-windows-10-and-windows-server-version-1709) you should instead:

* Start the ```Function Discovery Provider Host``` and ```Function Discovery Resource Publication``` services, and then set them to Automatic (Delayed Start).
* When you open Explorer Network, enable network discovery when you are prompted.

This feed also includes a WSD Name Service Daemon (wsdd2) by default, which replaces netbios so you can also see all samba shares in the explorer on Windows 8+ clients.

#### CPU problems
If your firmware support's ```renice``` (busybox process tools option) than the init script will lower all samba related processes, which can help to avoid samba stalling other processes.
