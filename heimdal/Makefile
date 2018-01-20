#
# Copyright (C) 2009-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=heimdal
PKG_VERSION:=7.5.0
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/$(PKG_NAME)/$(PKG_NAME)/releases/download/$(PKG_NAME)-$(PKG_VERSION)/
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_HASH:=c5a2a0030fcc728022fa2332bad85569084d1c3b9a59587b7ebe141b0532acad
PKG_LICENSE:=BSD-3-Clause

PKG_INSTALL:=1
HOST_BUILD_DEPENDS:=ncurses/host
PKG_BUILD_DEPENDS:=heimdal/host
#PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

HOST_CONFIGURE_ARGS += \
	--disable-shared \
	--enable-static \
	--without-openldap \
	--without-capng \
	--with-db-type-preference= \
	--without-sqlite3 \
	--without-libintl \
	--without-openssl \
	--without-berkeley-db \
	--without-readline \
	--without-libedit \
	--without-hesiod \
	--without-x \
	--disable-heimdal-documentation

define Host/Compile
	$(MAKE) -C $(HOST_BUILD_DIR)/include $(HOST_MAKE_FLAGS)
	$(MAKE) -C $(HOST_BUILD_DIR)/lib/roken $(HOST_MAKE_FLAGS)
	$(MAKE) -C $(HOST_BUILD_DIR)/lib/vers $(HOST_MAKE_FLAGS)
	$(MAKE) -C $(HOST_BUILD_DIR)/lib/com_err $(HOST_MAKE_FLAGS)
	$(MAKE) -C $(HOST_BUILD_DIR)/lib/asn1 $(HOST_MAKE_FLAGS)
	$(MAKE) -C $(HOST_BUILD_DIR)/lib/libedit $(HOST_MAKE_FLAGS)
	$(MAKE) -C $(HOST_BUILD_DIR)/lib/sl $(HOST_MAKE_FLAGS)
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/bin
	$(CP) $(HOST_BUILD_DIR)/lib/com_err/compile_et $(STAGING_DIR_HOST)/bin
	$(CP) $(HOST_BUILD_DIR)/lib/asn1/asn1_compile $(STAGING_DIR_HOST)/bin
	$(CP) $(HOST_BUILD_DIR)/lib/sl/slc $(STAGING_DIR_HOST)/bin
endef

EXTRA_CFLAGS += \
	-Wno-deprecated-declarations \
	-Wno-unused-variable \
	-Wno-unused-function \
	-Wno-maybe-uninitialized \
	-Wno-return-type \
	-Wno-enum-compare

define Build/Prepare
	$(call Build/Prepare/Default)
	$(CP) files/roken-h-process.pl $(PKG_BUILD_DIR)/cf
endef

define Package/heimdal
	SECTION:=network
	CATEGORY:=Network
	TITLE:=Heimdal $(PKG_VERSION) Kerberos 5
	URL:=http://www.h5l.org
	DEPENDS:= @BROKEN
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,heimdal))
