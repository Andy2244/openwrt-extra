include $(TOPDIR)/rules.mk

PKG_NAME:=libmill
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/sustrik/libmill.git
PKG_SOURCE_DATE:=2017-09-28
PKG_SOURCE_VERSION:=2dd13ae8a1e4c9b5b89670f813a185dd51c43a66
PKG_MIRROR_HASH:=ed0783b3420c59c1138d3e7fd31cdef8ba86c418d32a3e745639d9b043a9c524

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=MIT License
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libmill
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Go-style concurrency to C.
  URL:=http://libmill.org
endef

define Package/libmill/description
  Libmill is a library that introduces Go-style concurrency to C.
endef

# see issue #167 (GCC 6.2.1 breaks libmill)
TARGET_CFLAGS += -fno-stack-protector

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/libmill.h $(1)/usr/include/
	
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libmill.pc $(1)/usr/lib/pkgconfig/
	
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libmill.{a,so*} $(1)/usr/lib/
endef

define Package/libmill/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libmill.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libmill))
