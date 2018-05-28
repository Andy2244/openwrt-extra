## Openwrt extra package feed.

### Description

This is an OpenWrt package feed containing **Samba 4.8.x** and **SoftetherVPN (dev/git)** servers.

#### Note
Samba [VFS modules](https://wiki.samba.org/index.php/Virtual_File_System_Modules) are supported and can be added via luci.

The package includes experimental support for: **[ad-dc](https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller), [winbind](https://wiki.samba.org/index.php/Configuring_Winbindd_on_a_Samba_AD_DC), avahi, quota, acl** *(no cluster, printer,cups/iprint support)*

The size of the Samba4.ipk and deps are around 5.4 MB, so you need a >8MB NVRAM device to fit the final image or setup a [ext-root](https://openwrt.org/docs/guide-user/additional-software/extroot_configuration) *(recommend for ad-dc operation)*.

### Usage
**IMPORTANT: master branch was only tested/build against openwrt/master, package/master (May 2018)**

To use these packages, add the following line to your ```feeds.conf``` or ```feeds.conf.default``` in the OpenWrt buildroot:

```src-git extra https://github.com/Andy2244/openwrt-extra.git```

Than include and install all packages from your ```feeds.conf``` via:
```
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a
```
Afterwards run: 
```make menuconfig``` or ```make defconfig```
The packages should appear under **Network->Samba4** and **Network->VPN->softethervpn-server**. There is also a updated **Samba4 luci app** package, you should select.


### smb.conf.example

The ```smb.conf.example``` file shows what options to uncomment in the ```smb.conf.template``` to get a easy share working, without any extra user setup, all new files/folders will be maped to "root".

### Problems

If you cant see your share in the Windows 10 (1709+) explorer as a workgroup user, thats because the default state in Windows 10 is now to uninstall the old smb1 protocol, along with the computer browser service, which was needed to display netbios shares in the explorer. Its not recommend to reinstall the old smb1 package, but following this [article](https://support.microsoft.com/en-nz/help/4034314/smbv1-is-not-installed-windows-10-and-windows-server-version-1709) you should instead:

* Start the ```Function Discovery Provider Host``` and ```Function Discovery Resource Publication``` services, and then set them to Automatic (Delayed Start).
* When you open Explorer Network, enable network discovery when you are prompted.

This only works to find other Windows 8/10 shares without using netbios, so you still wont see the samba shares. So the only option is to use full network paths, since this is only a explorer display problem. So assuming the smb.conf.example names, in Windows explorer type: ```\\router\share```
* You can than permanently mount the share via explorer "map network drive".
* This also means for Windows 10 workgroup clients you don't need the netbios daemon and can either remove it from the package via ```make menuconfig``` options or disable it via luci.

#### CPU problems
If your firmware support's ```renice``` (busybox process tools option) than the init script will lower all samba related processes, which can help to avoid samba stalling other processes.
