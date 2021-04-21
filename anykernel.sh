# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=
do.devicecheck=0
do.modules=1
do.systemless=1
do.cleanup=1
do.cleanuponabort=1
'; } # end properties

# shell variables
block=auto;
is_slot_device=auto;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel install
dump_boot;

ui_print " "
ui_print " - Mounting system and vendor"
ui_print " "
mount -o rw,remount /system
mount -o rw,remount /vendor

ui_print " "
ui_print " - Backuping /system/build.prop to /system/build.prop.bak"
ui_print " "
cp /system/build.prop /system/build.prop.bak

ui_print " "
ui_print " - Change value in /system/build.prop for fix error on device boot"
ui_print " "
sed -i 's/ro.treble.enabled=true/ro.treble.enabled=false/g' /system/build.prop


#Install Magisk Module & Other
ui_print " - Installing Magisk Module for Automaticly Activate (insmod) All Modules (*.ko-files) at Start Your Android"

cp -rf AutoInsmodModules /data/adb/modules

UNAME=$(ls /tmp/anykernel/modules/system/lib/modules/)
NH_SYSTEM=/data/local/nhsystem

if
	test -d $NH_SYSTEM
then
	if
		test -d $NH_SYSTEM/kali-arm64
	then
		NH_PATH=$NH_SYSTEM/kali-arm64
	else
		NH_PATH=$NH_SYSTEM/kali-armhf
	fi
	mkdir -p $NH_PATH/lib/modules/
	cp -rf /tmp/anykernel/modules/system/lib/modules/$UNAME $NH_PATH/lib/modules/
	mkdir -p $NH_PATH/usr/src/$UNAME
	unzip /tmp/anykernel/kernel-headers.tar.xz -d $NH_PATH/usr/src/$UNAME
	chmod 777 -R $NH_PATH/lib/modules/$UNAME
	chmod 777 -R $NH_PATH/usr/src/$UNAME
else
	sleep 0
fi

write_boot;
