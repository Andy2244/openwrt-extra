# arch name mapping
QEMU_ARCH:=$(subst powerpc,ppc,$(ARCH))
# cpu name mapping
QEMU_CPU:=$(call qstrip,$(CONFIG_CPU_TYPE))
ifneq ($(QEMU_CPU),)
  QEMU_CPU:=$(subst +, ,$(QEMU_CPU))
  QEMU_CPU:=$(firstword $(QEMU_CPU))

  QEMU_CPU:=$(subst mpcore,,$(QEMU_CPU))
  QEMU_CPU:=$(subst generic,,$(QEMU_CPU))

  QEMU_CPU:=$(subst mips32,mips32r6-generic,$(QEMU_CPU))
  QEMU_CPU:=$(subst mips64,MIPS64R2-generic,$(QEMU_CPU))
  QEMU_CPU:=$(subst octeonplus,MIPS64R2-generic,$(QEMU_CPU))
  QEMU_CPU:=$(subst 8540,mpc8540,$(QEMU_CPU))
  QEMU_CPU:=$(subst arm926ej-s,arm926,$(QEMU_CPU))
  QEMU_CPU:=$(subst xscale,arm926,$(QEMU_CPU))
  QEMU_CPU:=$(subst arm1176jzf-s,arm1176,$(QEMU_CPU))
  QEMU_CPU:=$(subst arm1136j-s,arm1136,$(QEMU_CPU))
  QEMU_CPU:=$(subst cortex-a5,cortex-a7,$(QEMU_CPU))
  QEMU_CPU:=$(subst cortex-a73,cortex-a72,$(QEMU_CPU))
  QEMU_CPU:=$(subst 464fp,460ex,$(QEMU_CPU))
  QEMU_CPU:=$(subst fa526,sa1100,$(QEMU_CPU))
  QEMU_CPU:=$(subst pentium4,Conroe,$(QEMU_CPU))
  QEMU_CPU:=$(subst 74kc,74Kf,$(QEMU_CPU))
  QEMU_CPU:=$(subst 74kf,74Kf,$(QEMU_CPU))
  QEMU_CPU:=$(subst 24kc,24Kc,$(QEMU_CPU))
  QEMU_CPU:=$(subst 24kf,24Kf,$(QEMU_CPU))
  QEMU_CPU:=$(subst 34kf,34Kf,$(QEMU_CPU))
  QEMU_CPU:=$(subst 34kc,34Kf,$(QEMU_CPU))
endif

QEMU_CPU:=$(strip $(QEMU_CPU))
ifneq ($(QEMU_CPU),)
  QEMU_CPU:=-cpu $(QEMU_CPU)
endif

CROSS-ANSWER-OUT:=$(ARCH)-$(CONFIG_TARGET_BOARD)-$(CONFIG_TARGET_SUBTARGET)-$(CONFIG_CPU_TYPE)
CROSS-ANSWER-OUT:=$(call qstrip,$(CROSS-ANSWER-OUT))
