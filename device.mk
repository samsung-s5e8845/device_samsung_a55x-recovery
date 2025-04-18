#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/samsung/a55x

# Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/vabc_features.mk)

# Enforce generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
#$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# API
PRODUCT_SHIPPING_API_LEVEL := 34

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# A/B related packages
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

PRODUCT_PACKAGES += \
    mkshrc_vendor \
    toybox_vendor \
    sh_vendor

# f2fs utilities
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# Kernel Modules
PRODUCT_PACKAGES += \
    toolbox.vendor_ramdisk

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Enable Fuse Passthrough
PRODUCT_PROPERTY_OVERRIDES += persist.sys.fuse.passthrough.enable=true

# first_stage_ramdisk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.s5e8845:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.s5e8845 \
    $(LOCAL_PATH)/fstab.s5e8845:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.s5e8845 \
    $(LOCAL_PATH)/firmware/tsp/gt9895_a55x.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor/firmware/tsp/gt9895_a55x.bin \
    $(LOCAL_PATH)/firmware/sgpu/vangogh_lite_unified_evt0.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/lib/firmware/sgpu/vangogh_lite_unified_evt0.bin \
    $(LOCAL_PATH)/firmware/sgpu/vangogh_lite_unified_evt0.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/firmware/sgpu/vangogh_lite_unified_evt0.bin \
    $(LOCAL_PATH)/firmware/sgpu/vangogh_lite_unified_evt0.bin:$(TARGET_COPY_OUT_RECOVERY)/root/lib/firmware/sgpu/vangogh_lite_unified_evt0.bin \
    $(LOCAL_PATH)/firmware/tsp/gt9895_a55x.bin:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/firmware/tsp/gt9895_a55x.bin
