#EXTRA_CFLAGS += -mfpu=neon
#EXTRA_CFLAGS += -D__KERNEL__ -DKERNEL -DCONFIG_KEXEC -DCONFIG_KEXEC_JUMP -march=armv7-a -mtune=cortex-a9
EXTRA_CFLAGS += -DCONFIG_KEXEC -DCONFIG_ARM 

# Make this match the optimisation values of the kernel you're
# loading this into. Should work without changes, but it seems to
# crash on the Nexus One and Droid Pro. If you're compiling on an 
# Evo 4g, set this value to 1 and change the EXTRA_CFLAGS value to
# something appropriate to your phone
# EXTRA_CFLAGS += -O0

ARCH	?= arm
KDIR	?= $(HOME)/src/linux-3.18-msm
CROSS	?= armv7-unknown-linux-gnueabihf-

LDFLAGS=-static

obj-m += kexec_load.o

kexec_load-objs := kexec.o machine_kexec.o sys.o relocate_kernel.o \
	rodata.o

all: 
	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS) -C $(KDIR) M=$(PWD)
	modinfo kexec_load.o

clean:
	rm -rf *.o *.ko *.d .*.o.cmd .*.ko.cmd *.order .tmp_versions Module.symvers Modules.order *.mod.c
