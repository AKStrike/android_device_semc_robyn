# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file is the build configuration for a full Android
# build for x10mini hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, device/htc/x10mini/device_x10mini_eu.mk)

PRODUCT_PACKAGES += \
    VoiceDialer

# Install the features available on this device.
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml

# Specific x10mini init.rc
PRODUCT_COPY_FILES += \
    device/htc/x10mini/init.rc:root/init.rc \
    device/htc/x10mini/placeholder:system/sd/placeholder


PRODUCT_PROPERTY_OVERRIDES := \
    keyguard.no_require_sim=true \
    ro.ril.hsxpa=2 \
    ro.ril.hsupa.category=5 \
    ro.ril.def.agps.mode=2 \
    ro.media.dec.jpeg.memcap=10000000
    
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libril-qc-1.so \
    rild.libargs=-d /dev/smd0 \
    wifi.interface=wlan0
    
# Time between scans in seconds. Keep it high to minimize battery drain.
# This only affects the case in which there are remembered access points,
# but none are in range.
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.supplicant_scan_interval=45

# Configure agps cell location.  Must have Eclair libhtc_ril.so.

PRODUCT_PROPERTY_OVERRIDES += \
    ro.ril.def.agps.mode=2 \
    ro.ril.def.agps.feature=1

# Some more stuff:

PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1 \
    ro.ril.enable.a52=1 \
    ro.ril.enable.a53=1 \
    ro.com.google.clientidbase=android-htc \
    ro.com.google.clientidbase.yt=android-htc \
    ro.com.google.clientidbase.am=android-htc \
    ro.com.google.clientidbase.vs=android-htc \
    ro.com.google.clientidbase.gmm=android-htc \
    ro.media.enc.file.format       = 3gp,mp4 \
    ro.media.enc.vid.codec         = m4v,h263 \
    ro.media.enc.vid.h263.width    = 176,352 \
    ro.media.enc.vid.h263.height   = 144,288 \
    ro.media.enc.vid.h263.bps      = 64000,800000 \
    ro.media.enc.vid.h263.fps      = 1,30 \
    ro.media.enc.vid.m4v.width     = 176,352 \
    ro.media.enc.vid.m4v.height    = 144,288 \
    ro.media.enc.vid.m4v.bps       = 64000,800000 \
    ro.media.enc.vid.m4v.fps       = 1,30 \
    ro.media.dec.aud.wma.enabled=1 \
    ro.media.dec.vid.wmv.enabled=1 \
    settings.display.autobacklight=1 \
    media.stagefright.enable-player=true \
    media.stagefright.enable-meta=true \
    media.stagefright.enable-scan=true \
    media.stagefright.enable-http=true \
    keyguard.no_require_sim=true

# density in DPI of the LCD of this board. This is used to scale the UI
# appropriately. If this property is not defined, the default value is 160 dpi. 
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=120

# Increase dalvik heap size to prevent excessive GC with lots of apps installed.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.execution-mode=int:jit \
    dalvik.vm.heapsize=32m \
    ro.compcache.default=0

# media configuration xml file
PRODUCT_COPY_FILES += \
    device/htc/x10mini/media_profiles.xml:/system/etc/media_profiles.xml

# stuff common to all HTC phones
$(call inherit-product, device/htc/common/common.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/full.mk)

# Discard inherited values and use our own instead.
PRODUCT_NAME := full_x10mini
PRODUCT_DEVICE := x10mini
PRODUCT_MODEL := Full Android on X10 mini
PRODUCT_DEFAULT_WIFI_CHANNELS := 14