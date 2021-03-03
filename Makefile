obj-m += cm4-panel-jdi-lt070me05000.o

dtbo-y += cm4-dsi-lt070me05000.dtbo

KDIR ?= /lib/modules/$(shell uname -r)/build

targets += $(dtbo-y)    

always-y := $(dtbo-y)

all:
	make -C $(KDIR)  M=$(shell pwd)

clean:
	make -C $(KDIR)  M=$(shell pwd) clean
