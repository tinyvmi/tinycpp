XEN_ROOT = $(CURDIR)/../..

ifeq (,$(findstring clean,$(MAKECMDGOALS)))
include $(XEN_ROOT)/Config.mk
endif

CROSS_ROOT=$(CURDIR)/../cross-root-$(XEN_TARGET_ARCH)
CXX=$(CROSS_ROOT)/bin/$(XEN_TARGET_ARCH)-xen-elf-g++
AR=$(CROSS_ROOT)/bin/$(XEN_TARGET_ARCH)-xen-elf-ar
LD=$(CROSS_ROOT)/bin/$(XEN_TARGET_ARCH)-xen-elf-ld


MORE_CFLAGS += -isystem $(CROSS_ROOT)/lib/gcc/$(XEN_TARGET_ARCH)-xen-elf/5.4.0/include -isystem $(CROSS_ROOT)/include -isystem $(CROSS_ROOT)/$(XEN_TARGET_ARCH)-xen-elf/include -isystem $(CROSS_ROOT)/$(XEN_TARGET_ARCH)-xen-elf/include/c++/5.4.0

CXXFLAGS+= $(MORE_CFLAGS)

all: main.a

main.o:
	# TODO: debug: the following will yield error: 
	#      fatal error: bits/c++config.h: No such file or directory
	# solution is to remove all the flags.
	#
	# $(CXX) $(CPPFLAGS) $(CXXFLAGS) main.cpp -c -o main.o -static 
	#
	# 
	$(CXX) main.cpp -c -o main.o -static  # or
	# $(CXX) main.cpp -c -o main.o  # or even
	#
	#
	# TODO: the following also works, but is the wrong compiler.
	# g++ -c -o main.o main.cpp -static # 
	# g++ -c -o main.o main.cpp # 

main.a: main.o
	@echo "LELE: CPPFLAGS:"
	@echo "      $(CPPFLAGS)"
	@echo "LELE: CFLAGS:"
	@echo "      $(CFLAGS)"
	@echo "LELE: AR: $(AR)"
	$(AR) cr $@ $^

clean:
	rm -f *.a *.o
