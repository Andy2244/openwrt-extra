include $(TOPDIR)/rules.mk

PKG_NAME:=smbd
PKG_VERSION:=3.0.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/cifsd-team/smbd.git
PKG_SOURCE_DATE:=2019-12-28
PKG_SOURCE_VERSION:=a608ddfb71572d23615080adf3a0ab25e013bf85
PKG_MIRROR_HASH:=5c59935237d71a2a3875d80d9d3a6875e24889b918feaf5d66b6d6e970d7b3e2

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/fs-smbd
	SUBMENU:=Filesystems
	TITLE:=SMB kernel server support
	URL:=https://github.com/cifsd-team/smbd
	FILES:=$(PKG_BUILD_DIR)/smbd.ko
	DEPENDS:= \
		+kmod-nls-base \
		+kmod-nls-utf8 \
		+kmod-crypto-md4 \
		+kmod-crypto-md5 \
		+kmod-crypto-hmac \
		+kmod-crypto-arc4 \
		+kmod-crypto-ecb \
		+kmod-crypto-des \
		+kmod-crypto-sha256 \
		+kmod-crypto-cmac \
		+kmod-crypto-sha512 \
		+kmod-crypto-aead \
		+kmod-crypto-ccm \
		+kmod-crypto-gcm
endef

define KernelPackage/fs-smbd/description
  Smbd is an In-kernel SMB2/3 fileserver.
  It's an implementation of the SMB protocol in kernel space for sharing files and IPC services over network.
endef

# broken atm (needs CONFIG_KEYS=y)
#EXTRA_CFLAGS+=-DCONFIG_SMBD_ACL

define Build/Compile
	$(KERNEL_MAKE) SUBDIRS="$(PKG_BUILD_DIR)" \
	EXTRA_CFLAGS="$(EXTRA_CFLAGS)" \
	CONFIG_SMB_SERVER=m \
	modules
endef

$(eval $(call KernelPackage,fs-smbd))
