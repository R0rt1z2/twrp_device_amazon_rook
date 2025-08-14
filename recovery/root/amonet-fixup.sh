PATH=/sbin:/system/sbin:/system/bin:/system/xbin

/sbin/sh /sbin/fix-symlinks.sh
/sbin/sh /sbin/fix-bootpatch.sh

if grep -q "\-\-wipe_data" /dev/block/platform/mtk-msdc.0/by-name/MISC; then
    dd if=/dev/zero of=/dev/block/platform/mtk-msdc.0/by-name/MISC
    echo "Found --wipe_data, cleared MISC partition" > /tmp/wipe_data.log
fi

if grep -q "WIPE_DATA" /dev/block/platform/mtk-msdc.0/by-name/MISC; then
    make_ext4fs /dev/block/platform/mtk-msdc.0/by-name/userdata
    dd if=/dev/zero of=/dev/block/platform/mtk-msdc.0/by-name/MISC
    echo "coming from unlock, data format successful!" > /tmp/data.log
fi
