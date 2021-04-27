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

#Install Magisk Module
ui_print " "
ui_print " "
ui_print "Installing Magisk Module..."

cp -rf /tmp/anykernel/AutoInsmodModules /data/adb/modules

#Kernel headers
if
    [ -f /tmp/anykernel/headers.tar.xz ]
then
    ui_print " "
    ui_print " "
    ui_print "Installing Kernel Headers..."
    UNAME=$(ls /tmp/anykernel/modules/system/lib/modules/)
    NH_SYSTEM=/data/local/nhsystem
    for NH_PATH in $(ls $NH_SYSTEM)
    do NH_LIB=$NH_SYSTEM/$NH_PATH/usr/lib/modules
    rm -rf $NH_LIB/*
    cp -r /tmp/anykernel/modules/system/lib/modules/$UNAME $NH_LIB
    mkdir -p $NH_LIB/$UNAME/build
    busybox tar xf /tmp/anykernel/headers.tar.xz -C $NH_LIB/$UNAME/build
    done
else
sleep 0
fi

write_boot;
