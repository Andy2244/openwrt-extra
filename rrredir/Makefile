include $(TOPDIR)/rules.mk

PKG_NAME:=rrredir
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/rofl0r/rrredir.git
PKG_SOURCE_DATE:=2019-03-02
PKG_SOURCE_VERSION:=38de8a68a065763239d116d10b2ee8181520a7a8
PKG_MIRROR_HASH:=ab6d872a92aa296007a99687d7289bcbf430603599d8f6e32b1293fbc085956a

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
