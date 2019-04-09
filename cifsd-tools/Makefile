include $(TOPDIR)/rules.mk

PKG_NAME:=cifsd-tools
PKG_SOURCE_DATE:=2019-04-05
PKG_SOURCE_VERSION:=bfb5acfd886719eeef27311e5b5a7a44c05f088a
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/cifsd-team/cifsd-tools/tar.gz/$(PKG_SOURCE_VERSION)?
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_SOURCE_VERSION)
PKG_HASH:=b996518097d65028940272aca1a2ac1054d42a7a2619f219cfc4979caf0ee674

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
  SUBMENU:=Filesystem
  TITLE:=Kernel CIFS/SMB server support and userspace tools
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
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/cifsd.init $(1)/etc/init.d/cifsd
endef

define Package/cifsd-tools/conffiles
/etc/cifs/cifsdpwd.db
/etc/cifs/smb.conf
endef 

$(eval $(call BuildPackage,cifsd-tools))
