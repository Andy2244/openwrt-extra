include $(TOPDIR)/rules.mk

PKG_NAME:=rrredir
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/rofl0r/rrredir.git
PKG_SOURCE_DATE:=2019-04-08
PKG_SOURCE_VERSION:=ac5c131fe883f5d02d57d388ad40e3b58089bce2
PKG_MIRROR_HASH:=c5276df0b603e14e16a8bd354f830a2e05ffe1c79704385abd58c4746d6ec19c

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
