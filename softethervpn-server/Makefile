# Based partially on the versions of el1n and Federico Di Marco

include $(TOPDIR)/rules.mk

PKG_NAME:=softethervpn-server
PKG_SOURCE_COMMIT:=879dc8f
PKG_SOURCE_DATE:=2018-07-21
PKG_VERSION:=$(PKG_SOURCE_DATE)-$(PKG_SOURCE_COMMIT)
PKG_VERSION_NAME:=5.1-git
PKG_RELEASE:=2

PKG_SOURCE_URL:=https://codeload.github.com/SoftEtherVPN/SoftEtherVPN/tar.gz/$(PKG_SOURCE_COMMIT)?dummy=/
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_HASH:=5b2d43568af84a7e11ee3929916c3788d37a188b3d44613c4ee01fa0db708131
PKG_BUILD_DIR:=$(BUILD_DIR)/SoftEtherVPN-$(PKG_SOURCE_COMMIT)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/SoftEtherVPN-$(PKG_SOURCE_COMMIT)

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

HOST_BUILD_DEPENDS:=ncurses/host readline/host
PKG_BUILD_DEPENDS:=softethervpn-server/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/nls.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/softethervpn-server
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  DEPENDS:=+libpthread +librt +libreadline +libopenssl +libncurses +kmod-tun +zlib $(ICONV_DEPENDS)
  TITLE:=Multi-protocol VPN server (Dev. Edition $(PKG_VERSION_NAME))
  URL:=http://www.softether.org/
endef

# needs SSLv3_method for < 1.1
define Package/softethervpn-server/config
  select OPENSSL_WITH_SSL3
endef

define Package/softethervpn-server/description
SoftEther VPN supports SSL-VPN, OpenVPN, L2TP, EtherIP, L2TPv3 and IPsec as a single VPN software.
SoftEther VPN is not only an alternative VPN server to existing VPN products (OpenVPN, IPsec and MS-SSTP),
but has also original strong SSL-VPN protocol to penetrate any kinds of firewalls. 
Ultra-optimized SSL-VPN Protocol of SoftEther VPN has very fast throughput, low latency and firewall resistance.
endef

define Build/Prepare
	$(Build/Prepare/Default)
	# remove EUCJP defaults
	$(SED) 's/"eucJP"/"utf-8"/gI' $(PKG_BUILD_DIR)/src/Mayaqua/Internat.c
endef	

# Tune CFLAGS
TARGET_CFLAGS += \
	$(if $(CONFIG_OPENSSL_WITH_SSL3),,-DSSL_OP_NO_SSLv3)
	
define Host/Compile
	$(MAKE) -C $(HOST_BUILD_DIR)/src hamcorebuilder
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOSTPKG)/bin/
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/tmp/hamcorebuilder $(STAGING_DIR_HOSTPKG)/bin/
endef

define Build/Compile
	$(call Build/Compile/Default,vpnserver vpncmd hamcore-archive-build)
endef

define Build/Install
endef

define Package/softethervpn-server/conffiles
	/usr/libexec/softethervpn/vpn_server.config
	/usr/libexec/softethervpn/lang.config
endef

define Package/softethervpn-server/install
	$(INSTALL_DIR) $(1)/usr/libexec/softethervpn
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vpnserver/vpnserver $(1)/usr/libexec/softethervpn/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vpnserver/hamcore.se2 $(1)/usr/libexec/softethervpn/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vpncmd/vpncmd $(1)/usr/libexec/softethervpn/
	$(INSTALL_BIN) files/launcher.sh $(1)/usr/libexec/softethervpn/
	$(INSTALL_DATA) files/dummy $(1)/usr/libexec/softethervpn/vpn_server.config
	$(INSTALL_DATA) files/dummy $(1)/usr/libexec/softethervpn/lang.config
	$(INSTALL_DIR) $(1)/usr/bin
	$(LN) ../../usr/libexec/softethervpn/launcher.sh $(1)/usr/bin/vpncmd
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/vpnserver.init $(1)/etc/init.d/softethervpnserver
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,softethervpn-server))
