## Openwrt extra package feed.

### Description

This is an OpenWrt package feed containing **Samba 4.8 (rc2)** and **SoftetherVPN (dev/git)** servers.

#### Note
Samba [VFS modules](https://wiki.samba.org/index.php/Virtual_File_System_Modules) are supported and can be added via luci.

For now the samba server is a basic fileserver, without AC-DC, ADS, Cluster and printer support!
The size of the Samba4.ipk and deps are around 5.6 MB, so you need a >8MB NVRAM device to fit the final image or setup a [ext-root](https://lede-project.org/docs/user-guide/extroot_configuration).

### Usage
**IMPORTANT: master branch can only be build via latest package/master**

To use these packages, add the following line to your ```feeds.conf``` or ```feeds.conf.default``` in the OpenWrt buildroot:

```src-git extra https://github.com/Andy2244/openwrt-extra.git```

Than include and install all packages from your ```feeds.conf``` via:
```
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a
```
To manually install just this feed run:
```
./scripts/feeds update extra
./scripts/feeds install -a -f -p extra
```

Afterwards run: 
```make defconfig``` and ```make menuconfig```
The packages should appear under **Network->Samba4** and **Network->VPN->softethervpn-server**. There is also a updated **Samba4 luci app** package, you should select.


### smb.conf.example

The ```smb.conf.example``` file shows what options to uncomment in the ```smb.conf.template``` to get a easy share working, without any extra user setup, all new files/folders will be maped to "root".

### Problems

If you cant see your device/router, share in the Windows 10 (1703+) explorer/network as a workstation/workgroup user, thats because the default state in Windows 10 is now to uninstall the old smb1 protocol, along with the computer browser service, which was not updated to support smb2/3 to find, display netbios resources. Its also not recommend to reinstall the old smb1 package, but following this [article](https://support.microsoft.com/en-nz/help/4034314/smbv1-is-not-installed-windows-10-and-windows-server-version-1709) you should instead:

* Start the ```Function Discovery Provider Host``` and ```Function Discovery Resource Publication``` services, and then set them to Automatic (Delayed Start).
* When you open Explorer Network, enable network discovery when you are prompted.

This only works to find other Windows PC's without using netbios, so you still wont see the samba shares. Keep in mind using network paths work, this is only a explorer display problem. So assuming the smb.conf.example names, in Windows explorer type: ```\\router\share```
* You can than permanently mount the share via exploer "map network drive" and could than also disable Netbios via luci options.
