include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=cifsd
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/namjaejeon/cifsd.git
PKG_SOURCE_DATE:=2019-02-13
PKG_SOURCE_VERSION:=e946dd6cb5bf79f0f742b6092a0acbd36491898f
PKG_MIRROR_HASH:=7acfe855af3d7ba64ac0e7448cdde1638ad0516d510e5f20f386880eab22581c

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
