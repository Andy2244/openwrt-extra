## Openwrt extra package feed.

### Description

This is an OpenWrt package feed containing **Samba 4.7.x (stable)** server and **SoftetherVPN** server from the latest Dev git/master.

#### Note
For now the samba server is a basic fileserver, without AC-DC, ADS, Cluster and printer support!
The size of the Samba4.ipk is around 5-6 MB, so you probably need >8MB NVRAM device.

### Usage

To use these packages, add the following line to your ```feeds.conf``` or ```feeds.conf.default``` in the OpenWrt buildroot:

```src-git extra https://github.com/Andy2244/openwrt-extra.git```

Than include and install all packages from your ```feeds.conf``` via:
```
./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a
```
To manually install this package run:
```
./scripts/feeds update extra
./scripts/feeds install -a -p -f extra
```

Afterwards run: 
```make defconfig``` and ```make menuconfig```
The packages should appear under **Network->Samba4** and **Network->VPN->softethervpn-server**. There is also a updated **Samba4 luci app** package, you should select.


### smb.conf example

The example file shows what options to uncomment in the ```smb.conf.template``` to get a easy share working, without any extra user setup, all new files/folders will be maped to "root".
