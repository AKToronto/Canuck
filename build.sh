CROSS_COMPILE=/home/andrew/htc/kernels/toolchains/arm-eabi-4.6/bin/arm-eabi-
INITRAMFS_DIR=ramdisk.gz
KERNEL_NAME=AKToronto-Canuck
KERNEL_VNUMBER=1.3

# DO NOT MODIFY BELOW THIS LINE
CURRENT_DIR=`pwd`
NB_CPU=`grep processor /proc/cpuinfo | wc -l`
let NB_CPU+=1
if [[ -z $1 ]]
then
	echo "No configuration file defined"
	exit 1

else 
	if [[ ! -e "${CURRENT_DIR}/arch/arm/configs/$1" ]]
	then
		echo "Configuration file $1 not found"
		exit 1
	fi
	CONFIG=$1
fi


export KBUILD_BUILD_VERSION="${KERNEL_NAME}-v${KERNEL_VNUMBER}"


make $1
echo "Building kernel ${KBUILD_BUILD_VERSION} with configuration $CONFIG"
make ARCH=arm -j$NB_CPU CROSS_COMPILE=$CROSS_COMPILE


# Make boot.img
#echo "Making boot.img"
#cp arch/arm/boot/zImage .
#./mkbootimg --kernel zImage --ramdisk $INITRAMFS_DIR --base 80400000 --ramdiskaddr 81800000 --cmdline console=ttyHSL0,115200,n8 -o boot.img
#echo "Done."
