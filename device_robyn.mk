$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

# proprietary side of the device
$(call inherit-product-if-exists, vendor/semc/robyn/device_robyn-vendor.mk)


# Discard inherited values and use our own instead.
PRODUCT_NAME := X10Mini
PRODUCT_DEVICE := robyn
PRODUCT_MODEL := X10Mini

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/semc/robyn/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.    
DEVICE_PACKAGE_OVERLAYS := device/semc/robyn/overlay

# HAL libs and other system binaries
PRODUCT_PACKAGES += \
    gps.robyn \
    gralloc.robyn \
    copybit.robyn \
    sensors.robyn \
    lights.robyn \
    libcamera \
    libOmxCore \
    libmm-omxcore \
    screencap \
    hostap \
    rzscontrol

# Live wallpaper packages
PRODUCT_PACKAGES += \
    CMWallpapers \
    LiveWallpapersPicker \
    librs_jni \
    LiveWallpapers \
    MagicSmokeWallpapers \
    VisualizationWallpapers

# Extra packages
PRODUCT_PACKAGES += \
    Torch \
    ADWLauncher \

PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \

# Publish that we support the live wallpaper feature.
PRODUCT_COPY_FILES += \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:/system/etc/permissions/android.software.live_wallpaper.xml

# robyn specific gps.conf
PRODUCT_COPY_FILES += \
    device/semc/robyn/prebuilt/gps.conf:system/etc/gps.conf

PRODUCT_PROPERTY_OVERRIDES := \
    ro.media.dec.jpeg.memcap=10000000

PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libril-qc-1.so \
    rild.libargs=-d/dev/smd0 \
    ro.ril.hsxpa=2 \
    ro.ril.gprsclass=10 \
    ro.ril.hsupa.category=5 \
    ro.ril.disable.power.collapse=1 \
    wifi.interface=tiwlan0

# Time between scans in seconds. Keep it high to minimize battery drain.
# This only affects the case in which there are remembered access points,
# but none are in range.
#
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.supplicant_scan_interval=45

# Configure agps cell location.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.ril.def.agps.mode=2 \
    ro.ril.def.agps.feature=1

# density in DPI of the LCD of this board. This is used to scale the UI
# appropriately. If this property is not defined, the default value is 160 dpi. 
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=120 \
    persist.sys.use_16bpp_alpha=1

# Default network type
# 0 => WCDMA Preferred.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=0 \
    ro.telephony.call_ring.delay=0

# media configuration xml file
PRODUCT_COPY_FILES += \
    device/semc/robyn/media_profiles.xml:/system/etc/media_profiles.xml

# Turn off jni checks since they break FM Radio and Skype
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.android.checkjni=0

PRODUCT_COPY_FILES += \
    device/semc/robyn/placeholder:system/sd/placeholder

# Some more stuff:
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1 \
    ro.ril.enable.a52=1 \
    ro.ril.enable.a53=1 \
    ro.telephony.ril.v3=skipbrokendatacall,signalstrength,datacall \
    ro.media.enc.file.format       = 3gp,mp4 \
    ro.media.enc.vid.codec         = m4v,h263 \
    ro.media.enc.vid.h263.width    = 176,640 \
    ro.media.enc.vid.h263.height   = 144,480 \
    ro.media.enc.vid.h263.bps      = 64000,1600000 \
    ro.media.enc.vid.h263.fps      = 1,30 \
    ro.media.enc.vid.m4v.width     = 176,640 \
    ro.media.enc.vid.m4v.height    = 144,480 \
    ro.media.enc.vid.m4v.bps       = 64000,1600000 \
    ro.media.enc.vid.m4v.fps       = 1,30 \
    ro.media.dec.aud.wma.enabled=1 \
    ro.media.dec.vid.wmv.enabled=1 \
    settings.display.autobacklight=1 \
    media.stagefright.enable-player=true \
    media.stagefright.enable-meta=true \
    media.stagefright.enable-scan=true \
    media.stagefright.enable-http=true \
    keyguard.no_require_sim=true \
    windowsmgr.max_events_per_sec=150 \
    ro.opengles.version=131072 \
    persist.sys.scrollingcache=2

# Increase dalvik heap size to prevent excessive GC with lots of apps installed.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dexopt-flags=m=y \
    dalvik.vm.lockprof.threshold=500 \
    dalvik.vm.execution-mode=int:jit \
    dalvik.vm.heapsize=32m \
    ro.compcache.default=10 \
    ro.product.locale.region=US \
    persist.ro.ril.sms_sync_sending=1 \
    net.bt.name=Android-GingerDX

# Enable ti hotspot
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.hotspot.ti=1
    
# Use the semc-msm7x27 RIL
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.ril_class=semc-msm7x27 \
    ro.telephony.ril_skip_locked=true

# Workaround for usb disconnect kickback
PRODUCT_PROPERTY_OVERRIDES += \
    ro.tethering.kb_disconnect=1

# Theme Selection
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.themeId=ICSandwich \
    persist.sys.themePackageName=com.achep.theme.ICSandwich

## Extra prebuilt binaries
PRODUCT_COPY_FILES += \
    device/semc/robyn/prebuilt/hw_config.sh:system/etc/hw_config.sh \
    device/semc/robyn/prebuilt/FmRxService.apk:system/app/FmRxService.apk \
    device/semc/robyn/prebuilt/Radio.apk:system/app/Radio.apk \
    device/semc/robyn/prebuilt/SuquashiInputMethod.apk:system/app/SuquashiInputMethod.apk \
    device/semc/robyn/prebuilt/SystemConnector.apk:system/app/SystemConnector.apk \
    device/semc/robyn/prebuilt/com.sonyericsson.suquashi.jar:system/framework/com.sonyericsson.suquashi.jar \
    device/semc/robyn/prebuilt/fmreceiverif.jar:system/framework/fmreceiverif.jar \
    device/semc/robyn/prebuilt/SemcSmfmf.jar:system/framework/SemcSmfmf.jar \
    device/semc/robyn/prebuilt/vold.fstab:system/etc/vold.fstab \
    device/semc/robyn/prebuilt/usr/keylayout/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl \
    device/semc/robyn/placeholder:system/lib/modules/.placeholder

## Themes
PRODUCT_COPY_FILES += \
    device/semc/shakira/prebuilt/bootanimation.zip:/system/media/bootanimation.zip \
    device/semc/shakira/prebuilt/ICSandwich.apk:/system/app/ICSandwich.apk

## A2SD and extra init files
PRODUCT_COPY_FILES += \
    device/semc/robyn/prebuilt/a2sd:system/bin/a2sd \
    device/semc/robyn/prebuilt/10apps2sd:system/etc/init.d/10apps2sd \
    device/semc/robyn/prebuilt/05mountext:system/etc/init.d/05mountext \
    device/semc/robyn/prebuilt/04modules:system/etc/init.d/04modules \
    device/semc/robyn/prebuilt/06minicm:system/etc/init.d/06minicm \
    device/semc/robyn/prebuilt/zipalign:system/xbin/zipalign
    
## Extra Cyanogen vendor files
PRODUCT_COPY_FILES += \
    vendor/cyanogen/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

## GingerDX files
PRODUCT_COPY_FILES += \
    device/semc/shakira/prebuilt/GalleryDX.apk:/system/app/GalleryDX.apk \
    device/semc/shakira/prebuilt/GDXUpdateNotify.apk:/system/app/GDXUpdateNotify.apk \
    device/semc/shakira/prebuilt/HoloLauncher.apk:/system/app/HoloLauncher.apk \
    device/semc/shakira/prebuilt/GPSCountryOptimizer.apk:/system/app/GPSCountryOptimizer.apk \
    device/semc/shakira/prebuilt/libqpicjni88.so:/system/lib/libqpicjni88.so

## Battery Tweak
    device/semc/shakira/prebuilt/sysctl.conf:/system/etc/sysctl.conf

## SuperSU
PRODUCT_COPY_FILES += \
	device/semc/shakira/prebuilt/SuperSU.apk:system/app/SuperSU.apk \
	device/semc/shakira/prebuilt/su:system/xbin/su

## Extra Cyanogen vendor files
PRODUCT_COPY_FILES += \
    vendor/cyanogen/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

## GingerDX files
PRODUCT_COPY_FILES += \
    device/semc/shakira/prebuilt/GalleryDX.apk:/system/app/GalleryDX.apk \
    device/semc/shakira/prebuilt/GDXUpdateNotify.apk:/system/app/GDXUpdateNotify.apk \
    device/semc/shakira/prebuilt/HoloLauncher.apk:/system/app/HoloLauncher.apk \
    device/semc/shakira/prebuilt/GPSCountryOptimizer.apk:/system/app/GPSCountryOptimizer.apk \
    device/semc/shakira/prebuilt/libqpicjni88.so:/system/lib/libqpicjni88.so

## Gapps
PRODUCT_COPY_FILES += \
	device/semc/shakira/prebuilt/gapps/app/CarHomeGoogle.apk:system/app/CarHomeGoogle.apk \
	device/semc/shakira/prebuilt/gapps/app/FOTAKill.apk:system/app/FOTAKill.apk \
	device/semc/shakira/prebuilt/gapps/app/GenieWidget.apk:system/app/GenieWidget.apk \
	device/semc/shakira/prebuilt/gapps/app/Gmail.apk:system/app/Gmail.apk \
	device/semc/shakira/prebuilt/gapps/app/GoogleBackupTransport.apk:system/app/GoogleBackupTransport.apk \
	device/semc/shakira/prebuilt/gapps/app/GoogleCalendarSyncAdapter.apk:system/app/GoogleCalendarSyncAdapter.apk \
	device/semc/shakira/prebuilt/gapps/app/GoogleContactsSyncAdapter.apk:system/app/GoogleContactsSyncAdapter.apk \
	device/semc/shakira/prebuilt/gapps/app/GoogleFeedback.apk:system/app/GoogleFeedback.apk \
	device/semc/shakira/prebuilt/gapps/app/GooglePartnerSetup.apk:system/app/GooglePartnerSetup.apk \
	device/semc/shakira/prebuilt/gapps/app/GoogleQuickSearchBox.apk:system/app/GoogleQuickSearchBox.apk \
	device/semc/shakira/prebuilt/gapps/app/GoogleServicesFramework.apk:system/app/GoogleServicesFramework.apk \
	device/semc/shakira/prebuilt/gapps/app/LatinImeTutorial.apk:system/app/LatinImeTutorial.apk \
	device/semc/shakira/prebuilt/gapps/app/Maps.apk:system/app/Maps.apk \
	device/semc/shakira/prebuilt/gapps/app/MarketUpdater.apk:system/app/MarketUpdater.apk \
	device/semc/shakira/prebuilt/gapps/app/MediaUploader.apk:system/app/MediaUploader.apk \
	device/semc/shakira/prebuilt/gapps/app/NetworkLocation.apk:system/app/NetworkLocation.apk \
	device/semc/shakira/prebuilt/gapps/app/OneTimeInitializer.apk:system/app/OneTimeInitializer.apk \
	device/semc/shakira/prebuilt/gapps/app/SetupWizard.apk:system/app/SetupWizard.apk \
	device/semc/shakira/prebuilt/gapps/app/Talk.apk:system/app/Talk.apk \
	device/semc/shakira/prebuilt/gapps/app/Vending.apk:system/app/Vending.apk \
	device/semc/shakira/prebuilt/gapps/app/YouTube.apk:system/app/YouTube.apk \
	device/semc/shakira/prebuilt/gapps/app/VoiceSearch.apk:system/app/VoiceSearch.apk \
	device/semc/shakira/prebuilt/gapps/etc/permissions/com.google.android.maps.xml:system/etc/permissions/com.google.android.maps.xml \
	device/semc/shakira/prebuilt/gapps/etc/permissions/features.xml:system/etc/permissions/features.xml \
	device/semc/shakira/prebuilt/gapps/framework/com.google.android.maps.jar:system/framework/com.google.android.maps.jar \
	device/semc/shakira/prebuilt/gapps/lib/libtalk_jni.so:system/lib/libtalk_jni.so \
	device/semc/shakira/prebuilt/gapps/lib/libvoicesearch.so:system/lib/libvoicesearch.so
