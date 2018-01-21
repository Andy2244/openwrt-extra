#
# Copyright (C) 2007-2017 OpenWrt
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# makefile is based on https://github.com/hbl0307106015/packages/tree/samba and https://github.com/wongsyrone/lede-1

include $(TOPDIR)/rules.mk

PKG_NAME:=samba
PKG_VERSION:=4.7.4
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://download.samba.org/pub/samba/stable/
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_HASH:=fb12d0c4452f85b67b78bbeabd4c762d8feb8ff83e39d044d285120c2c488247
PKG_LICENSE:=GPL-3.0

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1
#PKG_FIXUP:=autoreconf
PKG_BUILD_DEPENDS:=heimdal/host qemu-userspace/host

include $(INCLUDE_DIR)/package.mk

define Package/samba4
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Samba $(PKG_VERSION) SMB/CIFS server/client/tools
  URL:=http://www.samba.org/
  DEPENDS:=+zlib +libpthread +libpopt +e2fsprogs +libcap +libdbus
endef

# used by the startup script to lower smbd priority (we assume embedded device workload)
define Package/samba4/config
  select BUSYBOX_CONFIG_RENICE
  select BUSYBOX_DEFAULT_RENICE
endef

define Package/samba4/description
	Since 1992, Samba has provided secure, stable and fast file and print services for all clients using the SMB/CIFS protocol,
	such as all versions of DOS and Windows, OS/2, Linux and many others.

	Samba is an important component to seamlessly integrate Linux/Unix Servers and Desktops into Active Directory environments.
	It can function both as a domain controller or as a regular domain member. 
	
	(Basic Samba 4 fileserver, without AC-DC, ADS, Cluster and printer support.)
endef

CONFIGURE_VARS += \
	CPP="$(TARGET_CROSS)cpp" \
	python_LDFLAGS="" \
	python_LIBDIR=""

CONFIGURE_ARGS = \
		--target=$(GNU_TARGET_NAME) \
		--program-prefix="" \
		--prefix=$(CONFIGURE_PREFIX) \
		--exec-prefix=$(CONFIGURE_PREFIX) \
		--bindir=$(CONFIGURE_PREFIX)/bin \
		--sbindir=$(CONFIGURE_PREFIX)/sbin \
		--libexecdir=$(CONFIGURE_PREFIX)/lib \
		--sysconfdir=/etc \
		--datadir=$(CONFIGURE_PREFIX)/share \
		--localstatedir=/var \
		--mandir=$(CONFIGURE_PREFIX)/man \
		--infodir=$(CONFIGURE_PREFIX)/info

CONFIGURE_ARGS += \
		--hostcc="$(HOSTCC)" \
		--cross-compile \
		--cross-execute='qemu-$(ARCH) -L $(STAGING_DIR_ROOT)' \
		--disable-avahi \
		--disable-cephfs \
		--disable-cups \
		--disable-fault-handling \
		--disable-glusterfs \
		--disable-iprint \
		--disable-python \
		--disable-rpath \
		--disable-rpath-install \
		--enable-fhs \
		--without-acl-support \
		--without-ads \
		--without-ad-dc \
		--without-automount \
		--without-dnsupdate \
		--without-iconv \
		--without-ldap \
		--without-lttng \
		--without-ntvfs-fileserver \
		--without-pam \
		--without-quotas \
		--without-systemd \
		--without-utmp \
		--without-winbind \
		--nopyc \
		--nopyo

CONFIGURE_ARGS += \
		--with-lockdir=/var/lock \
		--with-logfilebase=/var/log \
		--with-piddir=/var/run \
		--with-privatedir=/etc/samba \
		--without-dmapi \
		--disable-gnutls \
		--with-relro \
		--with-sendfile-support \
		--without-cluster-support \
		--without-fam \
		--without-gettext \
		--without-pie \
		--without-regedit \
		--with-syslog \
		--bundled-libraries='!asn1_compile,!compile_et' \
		--enable-auto-reconfigure
		
CONFIGURE_CMD = ./buildtools/bin/waf

# fix spam (Unable to open printcap file /etc/printcap for read!)
EXTRA_CFLAGS += -UPRINTCAP_NAME -DPRINTCAP_NAME=\"/dev/null\"

define Package/samba4/install
	# remove test
	rm -f $(PKG_INSTALL_DIR)/usr/bin/smbtorture
	rm -f $(PKG_INSTALL_DIR)/usr/bin/gentest
	rm -f $(PKG_INSTALL_DIR)/usr/bin/locktest
	rm -f $(PKG_INSTALL_DIR)/usr/bin/masktest
	# remove client
	rm -f $(PKG_INSTALL_DIR)/usr/bin/rpcclient
	rm -f $(PKG_INSTALL_DIR)/usr/bin/smbclient
	# remove net
	rm -f $(PKG_INSTALL_DIR)/usr/bin/net
	# config files
	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/samba $(1)/etc/init.d
	$(INSTALL_DATA) ./files/samba.config $(1)/etc/config/samba4
	$(INSTALL_DATA) ./files/smb.conf.template $(1)/etc/samba
	$(INSTALL_BIN) ./files/samba.init $(1)/etc/init.d/samba4
	# full install
	$(INSTALL_DIR) $(1)/usr
	$(CP) $(PKG_INSTALL_DIR)/usr/{lib,bin,sbin} $(1)/usr/
endef

define Package/samba4/conffiles
  /etc/config/samba4
  /etc/samba/smb.conf.template
  /etc/samba/smb.conf
  /etc/samba/smbpasswd
  /etc/samba/secrets.tdb
  /etc/samba/passdb.tdb
endef

$(eval $(call BuildPackage,samba4))
