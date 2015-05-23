#!/bin/bash
#make clean && make mrproper
export version=$1
export KBUILD_BUILD_USER=Jacob
export KBUILD_BUILD_HOST=Xile
export cross=~/SideProjects/.tmp/arm-eabi-6.0/bin/arm-eabi-
export CM_CHECK=`grep -c "case MDP_YCBYCR_H2V1:" drivers/video/msm/mdp4_overlay.c`
#if [ $CM_CHECK -eq 0 ] ; then
#git am CM/*
#fi
make ARCH=arm CROSS_COMPILE=${cross} -j32 vindicator_defconfig
make ARCH=arm CROSS_COMPILE=${cross} -j32
cp arch/arm/boot/zImage zip/kernel/zImage
find -name '*.ko' -exec cp -av {} zip/system/lib/modules/ \;
cd zip
zip -q -r Vindicator-N7-${version}-${2}.zip META-INF kernel data system
mkdir ../../Vindicator-out
mv Vindicator-N7-${version}-${2}.zip ../../Vindicator-out
rm kernel/zImage
rm system/lib/modules/*
#if [[ "$2" =~ "cm" || "$2" =~ "CM" ]] ; then
#git reset --hard HEAD~2
#fi
