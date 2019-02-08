include $(TOPDIR)/rules.mk

PKG_NAME:=cifsd-tools
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/namjaejeon/cifsd-tools.git
PKG_SOURCE_DATE:=2019-02-08
PKG_SOURCE_VERSION:=2b930c62bfe190ba0d4be2bb87118518c37a7aaf
PKG_MIRROR_HASH:=7dd691dce07c1948b648f0831c2a982ca095ba275b25d47c05d8bbbb75abd53c

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_REMOVE_FILES:=autogen.sh aclocal.m4

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/cifsd-tools
  SECTION:=net
  CATEGORY:=Network
  TITLE:=CIFS/SMB kernel server userspace tools
  DEPENDS:=+kmod-fs-cifsd +glib2 +libnl-core +libnl-genl $(ICONV_DEPENDS)
endef

define Package/cifsd-tools/description
  Userspace tools (cifsd, cifsadmin) for the CIFS/SMB kernel fileserver.
  The config file location is /etc/cifs/smb.conf
endef

define Package/cifsd-tools/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libcifsdtools.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/{cifsadmin,cifsd} $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/cifs
	$(INSTALL_DATA) ./files/smb.conf.example $(1)/etc/cifs/
	$(INSTALL_DATA) ./files/smb.conf.guest-example $(1)/etc/cifs/
	$(INSTALL_DATA) ./files/cifsdpwd.db $(1)/etc/cifs/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/cifsd.init $(1)/etc/init.d/cifsd
endef

define Package/cifsd-tools/conffiles
/etc/cifs/cifsdpwd.db
/etc/cifs/smb.conf
endef 

$(eval $(call BuildPackage,cifsd-tools))