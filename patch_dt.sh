#!/bin/bash

find device -name "lineage_*.mk" -exec sed -i 's|$(call inherit-product, vendor/lineage/config|#$(call inherit-product, vendor/lineage/config|g' {} \;
find device -name "*.mk" -exec sed -i 's|include device/lineage|#include device/lineage|g' {} \;

# Sepolicy
find device -name hal_lineage* -delete
find device hardware -wholename "*/sepolicy/*/file_contexts" -exec sed -i -e 's/\(.*\)u:object_r:hal_lineage_\(.*\)/#\1u:object_r:hal_lineage_\2/g' {} \;

# HALs
find device hardware -wholename "*/aidl/powershare" -exec rm -r {} \;
find device hardware -wholename "*/hidl/fastcharge" -exec rm -r {} \;
find device hardware -wholename "*/hidl/livedisplay" -exec rm -r {} \;
find device hardware -wholename "*/hidl/powershare" -exec rm -r {} \;
find device hardware -wholename "*/hidl/touch" -exec rm -r {} \;
find device -name manifest.xml -exec sed -i -z -e 's/[ ]*<hal format="\(aidl\|hidl\)">\n[ ]*<name>vendor.lineage.[^<]*<\/name>\n[ ]*<transport>hwbinder<\/transport>\n[ ]*<version>[^<]*<\/version>\(\n[ ]*<interface>\n[ ]*<name>[^<]*<\/name>\n[ ]*<instance>[^<]*<\/instance>\n[ ]*<\/interface>\)*\n[ ]*<\/hal>\n//g' {} \;
find device -name BoardConfig*.mk -exec sed -i -z -e 's/\([ ]*\\\)\n[ ]*vendor\/lineage\/config\/device_framework_matrix.xml//g' {} \;

# Samsung specific
rm -rf hardware/samsung/doze
rm -rf hardware/samsung/AdvancedDisplay
