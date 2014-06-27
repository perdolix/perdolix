BUILDROOT_GIT:=git://git.buildroot.net/buildroot
BUILDROOT_VER:=1ba3432ab3ec

all: buildroot
	make -C buildroot

buildroot:
	git clone $(BUILDROOT_GIT) --no-checkout --single-branch $@
	git --git-dir=$@/.git --work-tree=$@ checkout $(BUILDROOT_VER)
	cp $< $@/.config
	make -C $@ oldconfig

clean:
	make -C buildroot clean

distclean:
	rm -Rf buildroot

save_configs:
	make -C buildroot savedefconfig
	cp buildroot/output/build/linux-3.13/.config misc/config_linux

qemu_livecd:
	qemu -cdrom buildroot/output/images/rootfs.iso9660 -m 2G
