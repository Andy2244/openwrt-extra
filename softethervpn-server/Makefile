# Based partially on the versions of el1n and Federico Di Marco

include $(TOPDIR)/rules.mk

PKG_NAME:=softethervpn-server
PKG_VERSION_NAME:=5.1-git
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/SoftEtherVPN/SoftEtherVPN.git
PKG_SOURCE_DATE:=2018-09-19
PKG_SOURCE_VERSION:=a78bcb4f21b7d109874178011b1f794143c3b061
PKG_MIRROR_HASH:=7424b56e594b8c0e7e96cc4978ea8bc97c0fc3b271480c936a800a00a4cce813

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
  TITLE:=Multi-protocol VPN server v$(PKG_VERSION_NAME)
  URL:=http://www.softether.org/
endef

define Package/softethervpn-server/description
  SoftEther VPN supports SSL-VPN, OpenVPN, L2TP, EtherIP, L2TPv3 and IPsec as a single VPN software.
  SoftEther VPN is not only an alternative VPN server to existing VPN products (OpenVPN, IPsec and MS-SSTP),
  but has also original strong SSL-VPN protocol to penetrate any kinds of firewalls. 
  Ultra-optimized SSL-VPN Protocol of SoftEther VPN has very fast throughput, low latency and firewall resistance.
endef

export USE_MUSL=YES
# BUG: outdated host/include/elf.h
HOST_CFLAGS += -DAT_HWCAP2=26

TARGET_CFLAGS += $(FPIC)

define Host/Compile
	$(call Host/Compile/Default,hamcorebuilder) 
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOSTPKG)/bin/
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/tmp/hamcorebuilder $(STAGING_DIR_HOSTPKG)/bin/
endef

define Build/Configure
	# build as shared libs
	$(SED) 's,STATIC,SHARED,g' $(PKG_BUILD_DIR)/src/Mayaqua/CMakeLists.txt
	$(SED) 's,STATIC,SHARED,g' $(PKG_BUILD_DIR)/src/Cedar/CMakeLists.txt
	$(Build/Configure/Default)
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
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tmp/Cedar/libcedar.so $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tmp/Mayaqua/libmayaqua.so $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/libexec/softethervpn
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/build/vpnserver/vpnserver $(1)/usr/libexec/softethervpn/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/build/vpnserver/hamcore.se2 $(1)/usr/libexec/softethervpn/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/build/vpncmd/vpncmd $(1)/usr/libexec/softethervpn/
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
