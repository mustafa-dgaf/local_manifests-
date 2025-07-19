#!/bin/bash

find device -name "lineage_*.mk" -exec sed -i 's|$(call inherit-product, vendor/lineage/config|#$(call inherit-product, vendor/lineage/config|g' {} \;
find device -name "*.mk" -exec sed -i 's|include device/lineage|#include device/lineage|g' {} \;
# Samsung specific
rm -rf hardware/samsung/doze
rm -rf hardware/samsung/AdvancedDisplay
