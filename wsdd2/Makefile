include $(TOPDIR)/rules.mk

PKG_NAME:=wsdd2
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Andy2244/wsdd2.git
PKG_SOURCE_DATE:=2018-07-19
PKG_SOURCE_VERSION:=bef6a7ff569a7be1a586f34d85866d749f50c140
PKG_MIRROR_HASH:=e30e4416c62543768297e6ac3241def277cfaa18dd88cc784582a7f2b82bbb9f

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk

define Package/wsdd2
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=Web Services for Devices (WSD) daemon
  URL:=https://kb.netgear.com/2649/NETGEAR-Open-Source-Code-for-Programmers-GPL
endef

define Package/wsdd2/description
  Web Services for Devices or Web Services on Devices (WSD),
  is a Microsoft API to simplify programming connections to web service
  enabled devices, such as Printers, Scanners and File Shares.

  This daemon advertises and responds to probe requests from Windows clients looking for File Shares.
  It also implements LLMNR Multicast name lookup services. 
endef

define Build/Compile
  $(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) $(PKG_BUILD_DIR)/{wsdd2.c,wsd.c,llmnr.c} -o $(PKG_BUILD_DIR)/wsdd2
endef

define Package/wsdd2/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/wsdd2 $(1)/usr/bin/
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/wsdd2.init $(1)/etc/init.d/wsdd2
endef

$(eval $(call BuildPackage,wsdd2))
