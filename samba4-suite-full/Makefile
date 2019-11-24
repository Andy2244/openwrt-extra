# Based partially on (wongsyrone/hbl0307106015) versions
include $(TOPDIR)/rules.mk

PKG_NAME:=samba4-suite-full
PKG_VERSION:=4.9.15
PKG_RELEASE:=1

PKG_SOURCE:=samba-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://ftp.heanet.ie/mirrors/ftp.samba.org/stable/ \
		https://ftp.gwdg.de/pub/samba/stable/ \
		https://ftp.riken.jp/net/samba/samba/stable/ \
		http://www.nic.funet.fi/index/samba/pub/samba/stable/ \
		http://samba.mirror.bit.nl/samba/ftp/stable/ \
		https://download.samba.org/pub/samba/stable/
PKG_HASH:=377102b80b97941bf0d131b828cae8415190e5bdd2928c2e2c954e29f1904496

PKG_MAINTAINER:=Andy Walsh <andy.walsh44+github@gmail.com>
PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:samba:samba

HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/samba-$(PKG_VERSION)-suite-full
PKG_BUILD_DIR:=$(BUILD_DIR)/samba-$(PKG_VERSION)-suite-full

# samba4=(asn1_compile) e2fsprogs=(compile_et) nfs-kernel-server=(rpcgen)
HOST_BUILD_DEPENDS:=python/host nfs-kernel-server/host e2fsprogs/host
PKG_BUILD_DEPENDS:=samba4-suite-full/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/version.mk

TAR_OPTIONS+= --strip-components 1
TAR_CMD=$(HOST_TAR) -C $(1) $(TAR_OPTIONS)

define Package/samba4-suite-full
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Samba $(PKG_VERSION) Suite-Full (EXPERIMENTAL)
  URL:=https://www.samba.org/
  DEPENDS:= +zlib +libtirpc +libpopt +libcomerr +libreadline \
	+PACKAGE_libcap:libcap +PACKAGE_libpthread:libpthread +PACKAGE_libnettle:libnettle +PACKAGE_libgcrypt:libgcrypt +PACKAGE_libpam:libpam +PACKAGE_dbus:dbus \
	+attr +acl +libavahi-client \
	+python-base +python-crypto +libopenssl +libgnutls +libopenldap +jansson +libarchive
  EXTRA_DEPENDS:=$(if $(PACKAGE_samba4-libs),@BROKEN)
endef

define Package/samba4-suite-full/description
  The Samba software suite is a collection of programs that implements the
  SMB/CIFS protocol for UNIX systems, allowing you to serve files and printers.

  Samba 4 implements up-to protocol version SMB v3.1.1 (Win10), supports mDNS via AVAHI and a AD-DC setup.
  NOTE: This is the full Samba4 Suite, including ALL server, client, admin tools. (No cluster and printer support.)
endef

# add wsdd2 by default for discovery
define Package/samba4-suite-full/config
  depends on !PACKAGE_samba4-libs
  select PACKAGE_wsdd2
endef

TARGET_CFLAGS += -ffunction-sections -fdata-sections
TARGET_LDFLAGS += -Wl,--gc-sections

CONFIGURE_VARS += \
	CPP="$(TARGET_CROSS)cpp"

CONFIGURE_CMD = ./buildtools/bin/waf
HOST_CONFIGURE_CMD = ./buildtools/bin/waf

# Strip options that WAF configure script does not recognize
CONFIGURE_ARGS:=$(filter-out	\
	--target=%			\
	--host=%			\
	--build=%			\
	--program-prefix=%	\
	--program-suffix=% 	\
	--disable-nls		\
	--disable-ipv6		\
	, $(CONFIGURE_ARGS))

HOST_CONFIGURE_ARGS:=$(filter-out	\
	--target=%			\
	--host=%			\
	--build=%			\
	--program-prefix=%	\
	--program-suffix=% 	\
	--disable-nls		\
	--disable-ipv6		\
	, $(HOST_CONFIGURE_ARGS))

# Waf needs the "configure" argument
CONFIGURE_ARGS:=configure $(CONFIGURE_ARGS)
HOST_CONFIGURE_ARGS:=configure $(HOST_CONFIGURE_ARGS)

CONFIGURE_ARGS += \
		--hostcc="$(HOSTCC)" \
		--cross-compile \
		--cross-answers=cross-answers.txt \
		--disable-cups \
		--disable-iprint \
		--disable-cephfs \
		--disable-fault-handling \
		--disable-glusterfs \
		--enable-fhs \
		--without-automount \
		--without-iconv \
		--without-lttng \
		--without-ntvfs-fileserver \
		--without-pam \
		--without-systemd \
		--without-utmp \
		--without-dmapi \
		--without-fam \
		--without-gettext \
		--without-regedit \
		--without-gpgme

HOST_CONFIGURE_ARGS += \
		--hostcc="$(HOSTCC)" \
		--disable-cups \
		--disable-iprint \
		--disable-cephfs \
		--disable-fault-handling \
		--disable-glusterfs \
		--disable-rpath \
		--disable-rpath-install \
		--disable-rpath-private-install \
		--enable-fhs \
		--without-automount \
		--without-iconv \
		--without-lttng \
		--without-ntvfs-fileserver \
		--without-pam \
		--without-systemd \
		--without-utmp \
		--without-dmapi \
		--without-fam \
		--without-gettext \
		--without-regedit \
		--without-gpgme

HOST_CONFIGURE_ARGS += --disable-avahi --without-quotas --without-acl-support --without-winbind \
	--without-ad-dc --without-json-audit --without-libarchive --disable-python --nopyc --nopyo \
	--disable-gnutls --without-dnsupdate --without-ads --without-ldap
HOST_CONFIGURE_VARS += python_LDFLAGS="" python_LIBDIR=""

# Optional AES-NI support - https://lists.samba.org/archive/samba-technical/2017-September/122738.html
# Support for Nettle wasn't comitted
ifdef CONFIG_TARGET_x86_64
	CONFIGURE_ARGS += --accel-aes=intelaesni
else
	CONFIGURE_ARGS += --accel-aes=none
endif

CONFIGURE_ARGS += \
		--with-lockdir=/var/lock \
		--with-logfilebase=/var/log \
		--with-piddir=/var/run \
		--with-privatedir=/etc/samba
# features
CONFIGURE_ARGS += \
		--with-acl-support \
		--with-quotas \
		--enable-avahi \
		--enable-gnutls \
		--with-dnsupdate \
		--with-ads \
		--with-ldap \
		--with-winbind

TARGET_CFLAGS := -I$(STAGING_DIR)/usr/include/python2.7 $(TARGET_CFLAGS)

HOST_CONFIGURE_ARGS += \
		--with-static-modules=!DEFAULT,!FORCED \
		--with-shared-modules=!DEFAULT,!FORCED

# lib bundling
# NOTE: bundle + make private, we want to avoid version configuration (build, link) conflicts
#CONFIGURE_ARGS += --builtin-libraries=talloc,tevent,tevent-util,texpect,tdb,ldb,tdr,cmocka
HOST_CONFIGURE_ARGS += --builtin-libraries=replace --nonshared-binary=asn1_compile

CONFIGURE_ARGS += --bundled-libraries=talloc,tevent,tevent-util,texpect,tdb,ldb,tdr,cmocka,replace,!asn1_compile,!compile_et 
# BUG: --private-libraries, Does not work for System possible libs, will not get "samba4" suffix!
CONFIGURE_ARGS += --private-libraries=talloc,tevent,tevent-util,texpect,tdb,ldb,tdr,cmocka,replace
# use different lib extension as the normal 'samba4' package
CONFIGURE_ARGS += --private-library-extension=s4
# CONFIGURE_ARGS += --disable-symbol-versions

define Host/Compile
	(cd $(HOST_BUILD_DIR); \
		./buildtools/bin/waf build \
		--targets=asn1_compile \
	)
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOSTPKG)/bin/
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/bin/asn1_compile $(STAGING_DIR_HOSTPKG)/bin/
endef

define Build/Configure
	$(CP) ./waf-cross-answers/$(ARCH).txt $(PKG_BUILD_DIR)/cross-answers.txt
	echo 'Checking uname machine type: "$(ARCH)"' >> $(PKG_BUILD_DIR)/cross-answers.txt
	echo 'Checking uname release type: "$(LINUX_VERSION)"' >> $(PKG_BUILD_DIR)/cross-answers.txt
	echo 'Checking uname version type: "$(VERSION_DIST) Linux-$(LINUX_VERSION) $(shell date +%Y-%m-%d)"' >> $(PKG_BUILD_DIR)/cross-answers.txt
	# NOTE: For some unknown reason this answer is not needed on some hosts/distros, yet needed on others?
	echo 'Checking whether POSIX capabilities are available: OK' >> $(PKG_BUILD_DIR)/cross-answers.txt
	$(call Build/Configure/Default)
endef

# BUG: We need to use "waf install --targets=" otherwise a "make install" or "waf install" will retrigger a full recompile of all possible targets!
define Build/Compile
	(cd $(PKG_BUILD_DIR); \
		./buildtools/bin/waf install \
		--jobs=$(shell nproc) \
		--destdir="$(PKG_INSTALL_DIR)" \
	)
endef

# No default install see above
define Build/Install
endef

define Package/samba4-suite-full/install
	# remove large test packages
	$(RM) $(PKG_INSTALL_DIR)/usr/bin/smbtorture

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/samba $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/lib/python2.7
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/python2.7 $(1)/usr/lib/
	
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_INSTALL_DIR)/usr/sbin/* $(1)/usr/sbin/
	
	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/samba $(1)/etc/init.d
	$(INSTALL_CONF) ./files/samba.config $(1)/etc/config/samba4
	$(INSTALL_DATA) ./files/smb.conf.template $(1)/etc/samba
	$(INSTALL_BIN) ./files/samba.init $(1)/etc/init.d/samba4
endef

define Package/samba4-suite-full/conffiles
/etc/config/samba4
/etc/samba/smb.conf.template
/etc/samba/smb.conf
/etc/samba/smbpasswd
/etc/samba/secrets.tdb
/etc/samba/passdb.tdb
/etc/samba/idmap.ldb
/etc/samba/lmhosts
/etc/nsswitch.conf
/etc/krb5.conf
endef

$(eval $(call HostBuild))
$(eval $(call BuildPackage,samba4-suite-full))
