#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/non_ab_device.mk)

# Include all languages
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Inherit Yasvara (LineageOS based) common configuration.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from grus device
$(call inherit-product, device/xiaomi/grus/device.mk)

PRODUCT_NAME := yasvara_grus
PRODUCT_DEVICE := grus
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := MI 9 SE

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Relax VINTF kernel requirements (4.9 kernel on Android 17)
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# CTS is not a goal for this unofficial legacy port. Prune test/cts-root
# from Soong parsing: its orphaned modules (cts/ is dropped from the
# manifest, so cts_bionic_defaults is undefined) break Kati with a
# duplicate license-metadata copy error for CtsBionicRootTestCases.
PRODUCT_SOURCE_ROOT_DIRS += -test/cts-root

# Strip unnecessary density resources - grus 432 DPI falls in the xxhdpi bucket
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Dalvik heap - scaled for 6GB RAM
PRODUCT_VENDOR_PROPERTIES += \
    dalvik.vm.heapstartsize=16m \
    dalvik.vm.heapgrowthlimit=384m \
    dalvik.vm.heapsize=768m \
    dalvik.vm.heaptargetutilization=0.46 \
    dalvik.vm.heapminfree=8m \
    dalvik.vm.heapmaxfree=48m \
    dalvik.vm.dex2oat-Xms=64m \
    dalvik.vm.dex2oat-Xmx=512m

# Optimized DEXopt
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := speed-profile
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed
