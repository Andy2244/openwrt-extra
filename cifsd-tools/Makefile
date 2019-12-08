include $(TOPDIR)/rules.mk

PKG_NAME:=cifsd-tools
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/cifsd-team/cifsd-tools.git
PKG_SOURCE_DATE:=2019-11-30
PKG_SOURCE_VERSION:=830cba084ef70dd006a7f9acdf87fd07100754ff
PKG_MIRROR_HASH:=7f2ba448fcddb8929a73acd5f9beb5ecaae139ba4d6361946c957f43c844c26d

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
# Why does autoreconf not pickup CONFIG_PACKAGE_glib2 changes without deleting the config.* files?
PKG_REMOVE_FILES:=autogen.sh config.*

PKG_BUILD_DEPENDS:=glib2 libnl libiconv
PKG_CONFIG_DEPENDS:=CONFIG_PACKAGE_glib2

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/cifsd-tools/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Filesystem
  TITLE:=Kernel SMB/CIFS
  URL:=https://github.com/cifsd-team/cifsd-tools
  DEPENDS:=+PACKAGE_glib2:glib2 +PACKAGE_glib2:libnl-core +PACKAGE_glib2:libnl-genl $(ICONV_DEPENDS)
endef

define Package/cifsd-tools/Default/description
  Userspace tools for the SMB/CIFS kernel fileserver (cifsd.ko).
  The config file location is /etc/cifs/smb.conf
endef

define Package/cifsd-server
  $(call Package/cifsd-tools/Default)
  TITLE+= server
  DEPENDS+= +kmod-fs-cifsd
endef

define Package/cifsd-server/description
  installs: cifsd

  This provides the basic fileserver service and is the minimum needed to serve 'guest only' file shares.
endef

define Package/cifsd-utils
  $(call Package/cifsd-tools/Default)
  TITLE+= user management-util
endef

define Package/cifsd-utils/description
  installs: cifsuseradd (cifsshareadd)

  Tool needed to create the cifsdpwd.db, to manage per user share passwords.
  NOTE: Not needed for 'guest only' shares.
endef

define Package/cifsd-utils/config
	config CIFSD_UTILS_SHAREADD
		bool "Add cifsshareadd util"
		depends on PACKAGE_cifsd-utils
		help
			Add the cifsshareadd tool, to directly manipulate the /etc/cifs/smb.conf.
		default n
endef

CONFIGURE_ARGS += \
	--disable-shared \
	--enable-static

TARGET_CFLAGS += $(if $(CONFIG_PACKAGE_glib2),,-static)
TARGET_LDFLAGS += $(if $(CONFIG_PACKAGE_glib2),,--static)

define Build/Prepare
	$(Build/Prepare/Default)
	$(SED) 's/LIBNL_LIBS./& -liconv/' $(PKG_BUILD_DIR)/{cifsd,cifsshareadd,cifsuseradd}/Makefile.am
	# $(SED) 's/LIBNL_LIBS./& -liconv/' $(PKG_BUILD_DIR)/{cifsd,cifsshareadd,cifsuseradd}/Makefile.am
endef

define Package/cifsd-server/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/cifsd $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/cifs $(1)/etc/init.d
	$(INSTALL_CONF) ./files/cifsd.config $(1)/etc/config/cifsd
	$(INSTALL_DATA) ./files/smb.conf.template $(1)/etc/cifs/
	$(INSTALL_BIN) ./files/cifsd.init $(1)/etc/init.d/cifsd
	# copy examples until we have a wiki page
	$(INSTALL_DATA) ./files/cifsd.config.example $(1)/etc/cifs/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/Documentation/configuration.txt $(1)/etc/cifs/
endef

define Package/cifsd-utils/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/cifsuseradd $(1)/usr/sbin/
ifeq ($(CONFIG_CIFSD_UTILS_SHAREADD),y)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/cifsshareadd $(1)/usr/sbin/
endif
endef

define Package/cifsd-server/conffiles
/etc/config/cifsd
/etc/cifs/smb.conf.template
/etc/cifs/smb.conf
/etc/cifs/cifsdpwd.db
endef

$(eval $(call BuildPackage,cifsd-server))
$(eval $(call BuildPackage,cifsd-utils))
