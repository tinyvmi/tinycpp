XEN_ROOT = $(CURDIR)/../..

ifeq (,$(findstring clean,$(MAKECMDGOALS)))
include $(XEN_ROOT)/Config.mk
endif

CROSS_ROOT=$(CURDIR)/../cross-root-$(XEN_TARGET_ARCH)
CXX=$(CROSS_ROOT)/$(XEN_TARGET_ARCH)-xen-elf/bin/$(XEN_TARGET_ARCH)-xen-elf-g++
AR=$(CROSS_ROOT)/$(XEN_TARGET_ARCH)-xen-elf/bin/$(XEN_TARGET_ARCH)-xen-elf-ar
LD=$(CROSS_ROOT)/$(XEN_TARGET_ARCH)-xen-elf/bin/$(XEN_TARGET_ARCH)-xen-elf-ld

all: main.a

main.o:
	@echo 
	@echo "LELE: CXX: $(CXX)"
	@echo
	$(CXX) main.cpp -o main.o
main.a: main.o 
	@echo "LELE: AR: $(AR)"
	$(AR) cr $@ $^

clean:
	rm -f *.a *.o
