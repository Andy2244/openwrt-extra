include $(TOPDIR)/rules.mk

PKG_NAME:=sniproxy
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Intika-Linux-Proxy/SNI-SSL-Proxy.git
PKG_SOURCE_DATE:=2019-07-27
PKG_SOURCE_VERSION:=cb5cb6de97fbec38bb3d949f7f1a3fba6b8f5735
PKG_MIRROR_HASH:=b22ae456551fb9e23382e034a0459578545ba3bad5327a48eef885556471dfd8

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/sniproxy
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE:=Sniproxy
  DEPENDS:=+libmill
endef

define Package/sniproxy/description
  A sniproxy supporting incoming HTTP/HTTPS/IMAPs/POP3s/SMTPs traffic and upstream SOCKS5 proxy.
  
  SniProxy, proxify incoming connections based on the hostname contained in the initial request of the TCP session.
  This can be used to proxify connections based on domain names with a custom DNS server.
endef

define Package/sniproxy/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/sniproxy $(1)/usr/bin/
endef

$(eval $(call BuildPackage,sniproxy))
