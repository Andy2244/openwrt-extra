include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=cifsd
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/namjaejeon/cifsd.git
PKG_SOURCE_DATE:=2019-02-14
PKG_SOURCE_VERSION:=ca6dd64b656a096b3b17da911d6fb5bbe8d12ad2
PKG_MIRROR_HASH:=cdce91db394a42d4ee8b2d96c6dba66d51d422550e94467e99dc66b861471bec

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk

define KernelPackage/fs-cifsd
	SUBMENU:=Filesystems
	TITLE:=CIFS/SMB kernel server support
	FILES:=$(PKG_BUILD_DIR)/cifsd.$(LINUX_KMOD_SUFFIX)
	DEPENDS+= \
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
	KCONFIG:= \
		CONFIG_KEYS=y \
		CONFIG_CRYPTO_ARC4=y
endef

define KernelPackage/fs-cifsd/description
	Kernel module for a CIFS/SMBv2,3 fileserver.
endef

TARGET_CFLAGS+= -DCONFIG_CIFSD_ACL

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
		ARCH="$(LINUX_KARCH)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		M="$(PKG_BUILD_DIR)" \
		CFLAGS="$(TARGET_CFLAGS)" \
		CONFIG_CIFS_SERVER=m \
		modules
endef

$(eval $(call KernelPackage,fs-cifsd))
