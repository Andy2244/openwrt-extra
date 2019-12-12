include $(TOPDIR)/rules.mk

PKG_NAME:=cifsd
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/cifsd-team/cifsd.git
PKG_SOURCE_DATE:=2019-12-07
PKG_SOURCE_VERSION:=76063c33abb2217293f756d08521245405f9af39
PKG_MIRROR_HASH:=18df9f7acdfce07fdc3f9f51693a937029d47c3775edd21ea5b12b5d15ad8761

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/fs-cifsd
	SUBMENU:=Filesystems
	TITLE:=CIFS/SMB kernel server support
	URL:=https://github.com/cifsd-team/cifsd
	FILES:=$(PKG_BUILD_DIR)/cifsd.ko
	DEPENDS:= \
		+kmod-nls-base \
		+kmod-nls-utf8 \
		+kmod-crypto-md4 \
		+kmod-crypto-md5 \
		+kmod-crypto-hmac \
		+kmod-crypto-ecb \
		+kmod-crypto-des \
		+kmod-crypto-sha256 \
		+kmod-crypto-cmac \
		+kmod-crypto-sha512 \
		+kmod-crypto-aead \
		+kmod-crypto-ccm
endef

define KernelPackage/fs-cifsd/description
  Cifsd is an In-kernel SMB3/CIFS fileserver.
  It's an implementation of SMB/CIFS protocol in kernel space for sharing files and IPC services over network.
endef

# broken atm (needs CONFIG_KEYS=y)
#EXTRA_CFLAGS+=-DCONFIG_CIFSD_ACL

define Build/Compile
	$(KERNEL_MAKE) SUBDIRS="$(PKG_BUILD_DIR)" \
	EXTRA_CFLAGS="$(EXTRA_CFLAGS)" \
	CONFIG_CIFS_SERVER=m \
	modules
endef

$(eval $(call KernelPackage,fs-cifsd))
