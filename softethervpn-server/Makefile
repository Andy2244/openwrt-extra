include $(TOPDIR)/rules.mk

PKG_NAME:=softethervpn
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/SoftEtherVPN/SoftEtherVPN.git
PKG_SOURCE_DATE:=2018-06-28
PKG_SOURCE_VERSION:=be0ebb65c16474fdfb8112f0cf85ca29f465b086
PKG_MIRROR_HASH:=3eb78f1970c3f2aa1e78a8275efbfc730468d642d94a8f9d58ff0d1a207cba5b

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_DEPENDS:=softethervpn-server/host

include $(INCLUDE_DIR)/nls.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk
include $(INCLUDE_DIR)/host-build.mk

define Package/softethervpn-server
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  DEPENDS:=+libpthread +librt +libreadline +libopenssl +libncurses +kmod-tun +zlib $(ICONV_DEPENDS)
  TITLE:=Free Cross-platform Multi-protocol VPN server
  URL:=http://www.softether.org/
endef

# needs SSLv3_method for < 1.1
define Package/softethervpn-server/config
  select OPENSSL_WITH_SSL3
endef

define Package/softethervpn-server/description
SoftEther VPN is the world's only VPN software which supports SSL-VPN,
OpenVPN, L2TP, EtherIP, L2TPv3 and IPsec as a single VPN software. SoftEther VPN is not only an alternative VPN server to existing VPN products (OpenVPN,
IPsec and MS-SSTP), but has also original strong SSL-VPN protocol to penetrate any kinds of firewalls. Ultra-optimized SSL-VPN Protocol of SoftEther VPN
has very fast throughput, low latency and firewall resistance.
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
	$(MAKE) -C $(HOST_BUILD_DIR)/tmp hamcorebuilder
#	$(MAKE) -C $(HOST_BUILD_DIR)/tmp hamcore-archive-build
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOSTPKG)/bin
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
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vpnserver/vpnserver $(1)/usr/libexec/softethervpn
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vpnserver/hamcore.se2 $(1)/usr/libexec/softethervpn
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vpncmd/vpncmd $(1)/usr/libexec/softethervpn
	$(INSTALL_BIN) files/launcher.sh $(1)/usr/libexec/softethervpn

	$(INSTALL_DATA) files/dummy $(1)/usr/libexec/softethervpn/vpn_server.config
	$(INSTALL_DATA) files/dummy $(1)/usr/libexec/softethervpn/lang.config

	$(INSTALL_DIR) $(1)/usr/bin

	$(LN) ../../usr/libexec/softethervpn/launcher.sh $(1)/usr/bin/vpncmd

	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/vpnserver.init $(1)/etc/init.d/softethervpnserver
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,softethervpn-server))
