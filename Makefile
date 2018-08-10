XEN_ROOT = $(CURDIR)/../..

ifeq (,$(findstring clean,$(MAKECMDGOALS)))
include $(XEN_ROOT)/Config.mk
endif

CROSS_ROOT=$(CURDIR)/../cross-root-$(XEN_TARGET_ARCH)
CXX=$(CROSS_ROOT)/bin/$(XEN_TARGET_ARCH)-xen-elf-g++
AR=$(CROSS_ROOT)/bin/$(XEN_TARGET_ARCH)-xen-elf-ar
LD=$(CROSS_ROOT)/bin/$(XEN_TARGET_ARCH)-xen-elf-ld

MORE_CFLAGS += -isystem $(CROSS_ROOT)/lib/gcc/$(XEN_TARGET_ARCH)-xen-elf/5.4.0/include -isystem $(CROSS_ROOT)/include -isystem $(CROSS_ROOT)/$(XEN_TARGET_ARCH)-xen-elf/include -isystem $(CROSS_ROOT)/$(XEN_TARGET_ARCH)-xen-elf/include/c++/5.4.0

CFLAGS+= $(MORE_CFLAGS)

CPPFLAGS+= $(MORE_CFLAGS)

CXXFLAGS+= $(MORE_CFLAGS)

LDFLAGS+= -lstdc++ -lgcc -lc

all: main.a

main.o:
	@echo 
	@echo "LELE: CXX: "
	@echo "$(CXX)"
	@echo
	# $(CXX) $(CPPFLAGS) $(CXXFLAGS) main.cpp -c -o main.o -static
	# $(CXX) main.cpp -c -o main.o -static
	$(CXX) main.cpp -c -o main.o
	#g++ -c -o main.o main.cpp -static

main.a: main.o patch.o
	@echo "LELE: CPPFLAGS:"
	@echo "      $(CPPFLAGS)"
	@echo "LELE: CFLAGS:"
	@echo "      $(CFLAGS)"
	@echo "LELE: AR: $(AR)"
	$(AR) cr $@ $^

clean:
	rm -f *.a *.o
