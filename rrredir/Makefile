include $(TOPDIR)/rules.mk

PKG_NAME:=rrredir
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/rofl0r/rrredir.git
PKG_SOURCE_DATE:=2018-12-20
PKG_SOURCE_VERSION:=ef4eb6ca69d6922e0bd625b199cc5a925dd4977a
PKG_MIRROR_HASH:=3e0602bdec8439e67a9030b5298cae0e0180a67700030e8c1f7a48bdde7aaacf

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=MIT License
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk

define Package/rrredir
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE:=RR Redir - Round-Robin Port Redirector.
  DEPENDS:=+libpthread
endef

define Package/rrredir/description
  This is a port redirector program like the well-known redir,
  but with the ability to specify more than one target ip/port
  which will be tried one after the other in round-robin fashion, until the connection succeeds.
endef

define Package/rrredir/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/rrredir $(1)/usr/bin/
endef

$(eval $(call BuildPackage,rrredir))
