## Openwrt extra package feed.

### Description

This is an OpenWrt package feed containing **Samba 4.7.x (stable)** server and **SoftetherVPN** server from the latest Dev git/master.

#### Note
For now the samba server is a basic fileserver, without AC-DC, ADS, Cluster and printer support!
The size of the Samba4.ipk is around 5-6 MB, so you probably need >8MB NVRAM device.

### Usage

To use these packages, add the following line to your ```feeds.conf``` or ```feeds.conf.default``` in the OpenWrt buildroot:

```src-git extra https://github.com/Andy2244/openwrt-extra.git```

This feed should be included and enabled by default in the OpenWrt buildroot. To install all its package definitions, run:
```
./scripts/feeds update extra
./scripts/feeds install -a -p -f extra
```
The packages should appear under **Network->Samba4** and **Network->VPN->softethervpn-server**. There is also a updated **Samba4 luci app** package, you should select.
