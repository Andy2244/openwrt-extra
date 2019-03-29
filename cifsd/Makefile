include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=cifsd
PKG_SOURCE_DATE:=2019-03-28
PKG_SOURCE_VERSION:=290162b6726780f9453a971d8afb1b3406ce899b
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/cifsd-team/cifsd/tar.gz/$(PKG_SOURCE_VERSION)?
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_SOURCE_VERSION)
PKG_HASH:=bf254de1cc70775585757de025da8af38ae8f451a79f68df70c9773e7f1695cb

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk

define KernelPackage/fs-cifsd
	SUBMENU:=Filesystems
	TITLE:=CIFS/SMB kernel server support
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
	Kernel module for a CIFS/SMBv2,3 fileserver.
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
