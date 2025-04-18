#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Release name
PRODUCT_RELEASE_NAME := a55x

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit some common twrp stuff.
$(call inherit-product, vendor/pb/config/common.mk)

# Inherit from a55x device
$(call inherit-product, device/samsung/a55x/device.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := a55x
PRODUCT_NAME := pb_a55x
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-A556E
PRODUCT_MANUFACTURER := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung-ss
