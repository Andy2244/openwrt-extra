#
# Copyright (C) 2007-2017 OpenWrt
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# based on https://github.com/hbl0307106015/packages/tree/samba and https://github.com/wongsyrone/lede-1

include $(TOPDIR)/rules.mk

PKG_NAME:=samba
PKG_VERSION:=4.8.0rc2
PKG_RELEASE:=1

#PKG_SOURCE_URL:=https://download.samba.org/pub/samba/stable/
PKG_SOURCE_URL:=https://download.samba.org/pub/samba/rc/
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_HASH:=6c2f6fa8ca819af544c23083c74bda60928317a595af41af35ea4ef2e0691018
PKG_LICENSE:=GPL-3.0

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1
#PKG_BUILD_DEPENDS:=heimdal/host qemu-userspace/host
PKG_BUILD_DEPENDS:=qemu-userspace/host perl/host python/host

include $(INCLUDE_DIR)/package.mk

define Package/samba4
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Samba $(PKG_VERSION) SMB/CIFS server
  URL:=http://www.samba.org/
  DEPENDS:=+zlib +libpthread +libpopt +libcap +libdbus +libtirpc +libnettle +krb5-libs
  # +libgnutls +krb5-server
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

# WAF configure script does not recognize these options
CONFIGURE_ARGS:=$(filter-out	\
	--host=%		\
	--build=%		\
	--program-suffix=%	\
	--disable-nls		\
	--disable-ipv6		\
	, $(CONFIGURE_ARGS))

CONFIGURE_ARGS += \
		--hostcc="$(HOSTCC)" \
		--cross-compile \
		--cross-execute="qemu-$(ARCH) -L $(STAGING_DIR_ROOT)" \
		--disable-avahi \
		--disable-cephfs \
		--disable-cups \
		--disable-fault-handling \
		--disable-glusterfs \
		--disable-iprint \
		--disable-python \
		--disable-rpath \
		--disable-rpath-install \
		--disable-rpath-private-install \
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
		--without-fam \
		--without-gettext \
		--without-regedit \
		--without-gpgme \
		--enable-auto-reconfigure

CONFIGURE_ARGS += \
		--disable-gnutls \
		--bundled-libraries=talloc,tevent,tdb,ldb,cmocka,NONE \
		--builtin-libraries=talloc,tevent,tdb,ldb \
		--with-system-mitkrb5 "$(STAGING_DIR)/usr" \
		--with-system-mitkdc=/usr/sbin/krb5kdc

		## embedded-heimdal
		# --bundled-libraries=talloc,tevent,tdb,ldb,com_err,cmocka,roken,wind,hx509,asn1,heimbase,hcrypto,krb5,gssapi,heimntlm,hdb,kdc,NONE
		
		
# idmap_tdb,idmap_passdb,idmap_nss (idmap_tdb2,idmap_script) shared_only(idmap_autorid,idmap_rid,idmap_hash)
SAMBA4_IDMAP_MODULES=idmap_tdb,idmap_passdb,idmap_nss
# pdb_smbpasswd,pdb_tdbsam	(pdb_ads,pdb_sam,pdb_samba4,pdb_wbc_sam)
SAMBA4_PDB_MODULES=pdb_smbpasswd,pdb_tdbsam
# auth_builtin,auth_sam,auth_winbind,auth_unix (auth_script) #(auth_samba4)
SAMBA4_AUTH_MODULES=auth_builtin,auth_sam,auth_unix,auth_script
# vfs_default (vfs_recycle,vfs_audit,vfs_extd_audit,vfs_full_audit,vfs_netatalk,vfs_fake_perms,vfs_default_quota,vfs_readonly,vfs_cap,vfs_expand_msdfs
# vfs_shadow_copy,vfs_shadow_copy2,vfs_readahead,vfs_xattr_tdb,vfs_streams_xattr,vfs_streams_depot,vfs_acl_xattr,vfs_acl_tdb,vfs_preopen,vfs_catia,vfs_media_harmony
# vfs_unityed_media,vfs_fruit,vfs_shell_snap,vfs_commit,vfs_worm,vfs_crossrename,vfs_linux_xfs_sgid,vfs_time_audit,vfs_offline,vfs_syncops,vfs_dirsort,vfs_fileid,vfs_aio_fork,vfs_aio_pthread,vfs_btrfs
SAMBA4_VFS_MODULES=vfs_default,vfs_recycle,vfs_fake_perms,vfs_default_quota,vfs_readonly,vfs_cap,vfs_shadow_copy,vfs_shadow_copy2,vfs_xattr_tdb,vfs_streams_xattr,vfs_acl_xattr,vfs_acl_tdb,vfs_btrfs,vfs_aio_fork,vfs_aio_pthread,vfs_offline
# nss_info_template
SAMBA4_EXTRA_MODULES=nss_info_template

SAMBA4_MODULES=${SAMBA4_AUTH_MODULES},${SAMBA4_PDB_MODULES},${SAMBA4_IDMAP_MODULES},${SAMBA4_VFS_MODULES},${SAMBA4_EXTRA_MODULES}

CONFIGURE_ARGS += \
		--with-static-modules=!DEFAULT,!FORCED,$(SAMBA4_MODULES) \
		--with-shared-modules=!DEFAULT,!FORCED

define Build/Prepare
	$(Build/Prepare/Default)
	# un-bundle dnspython
	$(SED) '/"dns.resolver":/d' $(PKG_BUILD_DIR)/third_party/wscript
	# unbundle iso8601
	$(SED) '/"iso8601":/d' $(PKG_BUILD_DIR)/third_party/wscript
endef

##FIXME: will be redefined by header (how to override here?)
# fix spam (Unable to open printcap file /etc/printcap for read!)
#TARGET_CFLAGS += -UPRINTCAP_NAME -DPRINTCAP_NAME=\"/dev/null\"

TARGET_CFLAGS += -ffunction-sections -fdata-sections
TARGET_LDFLAGS += -Wl,--gc-sections

# configure what targets to build/install (is used via makefile waf wrapper) NOTE: Shared modules need to-be added to the target list explicitly!
BUILD_TARGETS=smbd/smbd,nmbd,smbpasswd,pdbedit,nmblookup,testparm
MAKE_VARS += \
	WAF_TARGETS=--targets=$(BUILD_TARGETS)

define Build/Compile
	# no need, since 'make(waf) install' via (PKG_INSTALL:=1) triggers a full build + install
endef

define Package/samba4/install
	# install init, config
	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/samba $(1)/etc/init.d
	$(INSTALL_DATA) ./files/samba.config $(1)/etc/config/samba4
	$(INSTALL_DATA) ./files/smb.conf.template $(1)/etc/samba
	$(INSTALL_BIN) ./files/samba.init $(1)/etc/init.d/samba4
	# install libs
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*.so* $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/samba/*.so* $(1)/usr/lib
	# install build targets
	$(INSTALL_DIR) $(1)/usr
	$(CP) $(PKG_INSTALL_DIR)/usr/{bin,sbin} $(1)/usr/
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
