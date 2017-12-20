#!/bin/bash

#export USER=sandy.luo
export PATH=/opt/openjdk-1.8/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux/bin:/opt/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:/opt/gnutools/arc-4.8-amlogic-20130904-r2/bin:/opt/gnutools/arc2.3-p0/elf32-4.2.1/bin:/opt/gnutools/arc2.3-p0/uclibc-4.2.1/bin:/opt/gcc-linaro-arm-linux-gnueabihf/bin:/opt/CodeSourcery/Sourcery_G++_Lite/bin:/opt/CodeSourcery/Sourcery_G++_Lite/arm-none-eabi/bin:/opt/CodeSourcery/Sourcery_G++_Lite/arm-none-linux-gnueabi/bin:/opt/arc-4.8-amlogic-20130904-r2/bin:/opt/gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux/bin:/opt/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:/opt/aarch64-cros-linux-gnu/aarch64/bin:/opt/metaware-2013.09/MetaWare/arc/bin:/opt/fbc-main/tool/bin:/home/sandy.luo/bin

#export PATH=$PATH:/usr/lib/jvm/java-8-openjdk-amd64/bin:/mnt/nfsroot/sandy.luo/sandy/n-amlogic/out/host/linux-x86/bin:/mnt/nfsroot/sandy.luo/sandy/n-amlogic/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin:/mnt/nfsroot/sandy.luo/sandy/n-amlogic/prebuilts/gcc/linux-x86/:/mnt/nfsroot/sandy.luo/sandy/n-amlogic/development/scripts:/mnt/nfsroot/sandy.luo/sandy/n-amlogic/prebuilts/devtools/tools:/mnt/nfsroot/sandy.luo/sandy/n-amlogic/external/selinux/prebuilts/bin:/opt/openjdk-1.8/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux/bin:/opt/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:/opt/gnutools/arc-4.8-amlogic-20130904-r2/bin:/opt/gnutools/arc2.3-p0/elf32-4.2.1/bin:/opt/gnutools/arc2.3-p0/uclibc-4.2.1/bin:/opt/gcc-linaro-arm-linux-gnueabihf/bin:/opt/CodeSourcery/Sourcery_G++_Lite/bin:/opt/CodeSourcery/Sourcery_G++_Lite/arm-none-eabi/bin:/opt/CodeSourcery/Sourcery_G++_Lite/arm-none-linux-gnueabi/bin:/opt/arc-4.8-amlogic-20130904-r2/bin:/opt/gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux/bin:/opt/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:/opt/aarch64-cros-linux-gnu/aarch64/bin:/opt/metaware-2013.09/MetaWare/arc/bin:/opt/fbc-main/tool/bin:/home/sandy.luo/bin
SOURCE_DIR0="/mnt/nfsroot/sandy.luo/save_auto_build_code/txlx/r321"
SOURCE_CODE_DIR="/mnt/nfsroot/sandy.luo/sandy/n-amlogic-r321"
DATE=`date +%F`
ICS_LOGFILE="/mnt/nfsroot/sandy.luo/save_auto_build_code/log/android_n_r321_sandyluo_$DATE.log"
# 0. some variables
#step
STEP1_GET_CODE=0
STEP2_CHECKOUT_BRANCH=0
STEP3_ROOTFS_MAKE=1
#code
DEFAULT_BRANCH=jb-mr1-amlogic
DEVICE_BRANCH=jb-mr1-amlogic
KERNEL_BRANCH=amlogic-3.0
CUSTOMER_BRANCH=master
ROOTFS_DIR_NAME="n-amlogic-r321"
#code
#rootfs 
LUNCH_NUM=txlx_t962e_r321-userdebug-32
TASK_NUM=38 #VNC ALLOW ONE TASK ONLY
REPO_TASK_NUM=18 #VNC ALLOW ONE TASK ONLY
#kernel
time=0
AML_BOARD=r321
DEFAULT_CONFIG=meson6_g24_jb_defconfig 
DEFAULT_RECOVERY_CONFIG=meson6_g24_jb_defconfig
DATE=`date +%Y%m%d%H%M%S`

# 3. rootfs make complie
if [ $STEP3_ROOTFS_MAKE -ne 0 ];then
   	echo $(date) >> $ICS_LOGFILE
   	echo $(pwd) >> $ICS_LOGFILE
   	echo $(whoami) >> $ICS_LOGFILE
   	echo $PATH >> $ICS_LOGFILE
   	echo "=================" >> $ICS_LOGFILE
    rm -fr n-amlogic-r321
    mkdir n-amlogic-r321
    cd n-amlogic-r321
    repo init -u git://git.myamlogic.com/platform/manifest.git -b n-amlogic --repo-url=git://10.8.9.5/tools/repo.git
    repo sync -j8
    repo sync -j4
    repo sync -j8
	#repo forall -c 'git checkout .;git clean -df'
	repo init -m tv_trunk.xml
	repo sync -j$REPO_TASK_NUM
	repo sync -j4
	DATE=`date +%Y-%m-%d-%H-%M-%S`
	repo manifest -r -o android_n-r321-ori-$DATE.xml
    repo sync -j$REPO_TASK_NUM
    repo sync -j4
	DATE=`date +%Y-%m-%d-%H-%M-%S`
	MANIFEST_FILE=android_n-r321-new-$DATE.xml
	repo manifest -r -o $MANIFEST_FILE
	cp ../build_patch/qianlei_framework_base_home_power_key_print.patch ./frameworks/base/
	cp ../build_patch/device_amlogic_BT_disable.patch ./device/amlogic/
	cp ../build_patch/uboot.patch ./uboot/
	cp ../dtd_save/vender_amlogic_tv_tvserve.patch ./vendor/amlogic/tv/tvserver/

	cd ./vendor/amlogic/tv/tvserver
	git apply vender_amlogic_tv_tvserve.patch
	cd -

	cd uboot
	git apply uboot.patch
	cd -
	cd device/amlogic
	git apply device_amlogic_BT_disable.patch
	cd -
	cd frameworks/base
	git apply qianlei_framework_base_home_power_key_print.patch
	cd -
	cd common
#	git apply 0001-PD-117432-fix-image.gz-image.lzo-wrong-size-in-multi.patch
#	cd ../../android_L/common
	#cp -fr ddr.patch ../uboot/
	# cp -fr ../../android_L/common/system_core.patch ../system/core/
	#git apply watchdog_debug_1126.patch
	cd ..
	cd system/core
	#git apply system_core.patch
	cd ../..
	cd uboot
	#git apply ddr.patch
	make distclean
    ./mk txlx_t962e_r321_v1
	cd ..
	echo "start to make rootfs"
	. build/envsetup.sh
	lunch $LUNCH_NUM 2>> $ICS_LOGFILE
	rm -fr out
	cp -fr uboot/fip/u-boot.bin device/amlogic/txlx_t962e_r321/u-boot.bin 2>> $ICS_LOGFILE
	cp -fr uboot/fip/u-boot.bin.usb.bl2 device/amlogic/txlx_t962e_r321/upgrade/ 2>> $ICS_LOGFILE
	cp -fr uboot/fip/u-boot.bin.usb.tpl device/amlogic/txlx_t962e_r321/upgrade/ 2>> $ICS_LOGFILE
	cp -fr uboot/fip/u-boot.bin.sd.bin device/amlogic/txlx_t962e_r321/upgrade/ 2>> $ICS_LOGFILE
#	make update-api -j$TASK_NUM 2>> $ICS_LOGFILE
	make  otapackage -j$TASK_NUM 2>> $ICS_LOGFILE
#	rm -fr out/target/product/txlx_t962e_r321/obj/KERNEL_OBJ/
	make  otapackage -j$TASK_NUM 2>> $ICS_LOGFILE
	make  otapackage -j$TASK_NUM 2>> $ICS_LOGFILE
		echo "finish" 2>> $ICS_LOGFILE

	if [ $? -ne 0 ];then
        echo "rootfs make failed,exit!"
        exit
	fi
	echo "make finished"
	DATE=`date +%Y-%m-%d`
	#mkdir -p $SOURCE_DIR0/$DATE
	DEST_DIR="$SOURCE_DIR0/$DATE"
	ICS_LOGFILE="$DEST_DIR/autobuild_jb_$DATE.log"
	if [ -d $DEST_DIR ]; then
	#cp -f $SOURCE_CODE_DIR/out/target/product/txlx_t962e_r321/aml_upgrade_package.img  $DEST_DIR				2>> $ICS_LOGFILE
#	repo forall -c 'git checkout .;git clean -df'
#	repo init -m default.xml
#	repo sync -j$REPO_TASK_NUM
    DATE=`date +%Y-%m-%d`
    UPDATE_ZIP=`ls $SOURCE_CODE_DIR/out/target/product/txlx_t962e_r321/r321*.zip`

	else
		echo "Sorry, no folder found, will exit...."							2>> $ICS_LOGFILE
	fi
	date "+%Y-%m-%d %H:%M:%S"
fi

