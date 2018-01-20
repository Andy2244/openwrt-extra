# Openwrt extra package feed.

## Description

This is an OpenWrt package feed containing **Samba 4.7.x** server and **SoftetherVPN** server from latest Dev git/master.

## Usage

To use these packages, add the following line to your ```feeds.conf``` or ```feeds.conf.default``` in the OpenWrt buildroot:

```src-git extra https://github.com/Andy2244/openwrt-extra.git```

This feed should be included and enabled by default in the OpenWrt buildroot. To install all its package definitions, run:
```
./scripts/feeds update extra
./scripts/feeds install -a -p -f extra
```
The packages should appear under **Network->Samba4** and **Network->VPN->softethervpn-server**. There is also a updated **Samba4 luci app** package, you should select.
