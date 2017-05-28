#!/bin/bash

DTBH_PLATFORM_CODE=0x50a6
DTBH_SUBTYPE_CODE=0x217584da

export ARCH=arm64

case "$1" in
	a3)
	    VARIANT="a3xelte"
	    ;;

	j7)
	    VARIANT="j7elte"
	    ;;

    twrp-a3)
	    VARIANT="twrp_a3"
	    ;;

	*)
	    VARIANT="a3xelte"
esac


if [ ! -d $(pwd)/output ];
    then
        mkdir $(pwd)/output;
    fi

make -C $(pwd) O=output ARCH=arm64 "lineageos_"$VARIANT"_defconfig"
make -j7 -C $(pwd) O=output ARCH=arm64

$(pwd)/dtbTool  -o "$(pwd)/output/arch/arm64/boot/dt.img" -s 2048 -d "$(pwd)/output/arch/arm64/boot/dts/" --platform $DTBH_PLATFORM_CODE --subtype $DTBH_SUBTYPE_CODE
cp output/arch/arm64/boot/Image  output/arch/arm64/boot/boot.img-kernel

exit