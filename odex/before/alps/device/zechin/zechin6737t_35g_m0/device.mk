
include device/zechin/$(MTK_TARGET_PROJECT)/ProjectConfig.mk


######################################################

# PRODUCT_COPY_FILES overwrite
# Please add flavor project's PRODUCT_COPY_FILES here.
# It will overwrite base project's PRODUCT_COPY_FILES.
PRODUCT_PACKAGES += tiny_fallocate
PRODUCT_COPY_FILES += device/zechin/$(MTK_TARGET_PROJECT)/enableswap.sh:root/enableswap.sh
PRODUCT_COPY_FILES += device/mediatek/common/disableswap.sh:root/disableswap.sh


#For GMO to reduce runtime memroy usage
ifeq ($(MTK_GMO_RAM_OPTIMIZE),yes)

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.config.low_ram=true
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.sf.lcd_density=240

ifneq ($(strip $(MTK_BSP_PACKAGE)),yes)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.hwui.path_cache_size=0
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.hwui.text_small_cache_width=512
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.hwui.text_small_cache_height=256
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.hwui.disable_asset_atlas=true
endif

# Disable fast starting window in GMO project
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.mtk_perf_fast_start_win=0

#Images for LCD test in factory mode
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/common/factory/res/images/lcd_test_00_lca.png:system/res/images/lcd_test_00.png
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/common/factory/res/images/lcd_test_01_lca.png:system/res/images/lcd_test_01.png
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/common/factory/res/images/lcd_test_02_lca.png:system/res/images/lcd_test_02.png

MTK_ART_OPT_LOW_RAM_MODE := true
MTK_ART_OPT_ENABLE := true

ifeq ($(TARGET_BUILD_VARIANT),user)
WITH_DEXPREOPT := true
DONT_DEXPREOPT_PREBUILTS := true
endif
endif

# Reduce the max-size of 264 venc for GMO project
PRODUCT_COPY_FILES += device/zechin/$(MTK_TARGET_PROJECT)/media_codecs_mediatek_video.xml:system/etc/media_codecs_mediatek_video.xml

# overlay has priorities. high <-> low.
DEVICE_PACKAGE_OVERLAYS += device/zechin/$(MTK_TARGET_PROJECT)/overlay
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.sf.lcd_density=240

#######################################################

#For GMO to reduce runtime memroy usage
ifeq (yes,$(strip $(MTK_GMO_RAM_OPTIMIZE)))

ifeq (0x20000000,$(strip $(CUSTOM_CONFIG_MAX_DRAM_SIZE)))

PRODUCT_PACKAGES += tiny_fallocate
PRODUCT_COPY_FILES += device/mediatek/common/enableswap_gmo.sh:root/enableswap.sh
PRODUCT_COPY_FILES += device/mediatek/common/disableswap.sh:root/disableswap.sh
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.config.low_ram=true
endif


ifneq ($(strip $(MTK_BSP_PACKAGE)),yes)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.hwui.path_cache_size=0
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.hwui.text_small_cache_width=512
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.hwui.text_small_cache_height=256
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.hwui.disable_asset_atlas=true
endif

# Disable fast starting window in GMO project
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.mtk_perf_fast_start_win=0

#Images for LCD test in factory mode
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/common/factory/res/images/lcd_test_00_lca.png:system/res/images/lcd_test_00.png
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/common/factory/res/images/lcd_test_01_lca.png:system/res/images/lcd_test_01.png
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/common/factory/res/images/lcd_test_02_lca.png:system/res/images/lcd_test_02.png

MTK_ART_OPT_LOW_RAM_MODE := true
MTK_ART_OPT_ENABLE := true

ifeq ($(TARGET_BUILD_VARIANT),user)
WITH_DEXPREOPT := true
DONT_DEXPREOPT_PREBUILTS := true
endif


# Reduce the max-size of 264 venc for GMO project
PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/media_codecs_mediatek_video_gmo.xml:system/etc/media_codecs_mediatek_video.xml

endif

# PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/egl.cfg:system/lib/egl/egl.cfg
# PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/ueventd.mt6735.rc:root/ueventd.mt6735.rc

PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/factory_init.project.rc:root/factory_init.project.rc
PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/init.project.rc:root/init.project.rc
PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/meta_init.project.rc:root/meta_init.project.rc

ifeq ($(strip $(MTK_C2K_SUPPORT)),yes)
PRODUCT_COPY_FILES += device/mediatek/mt6735/init.c2k.rc:root/init.c2k.rc
PRODUCT_COPY_FILES += device/mediatek/mt6735/meta_init.c2k.rc:root/meta_init.c2k.rc
endif

ifeq ($(MTK_SMARTBOOK_SUPPORT),yes)
PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/sbk-kpd.kl:system/usr/keylayout/sbk-kpd.kl \
                      device/zechin/zechin6737t_35g_m0/sbk-kpd.kcm:system/usr/keychars/sbk-kpd.kcm
endif

# Add FlashTool needed files
#PRODUCT_COPY_FILES += device/zechin/$(MTK_TARGET_PROJECT)/EBR1:EBR1
#ifneq ($(wildcard device/zechin/$(MTK_TARGET_PROJECT)/EBR2),)
#  PRODUCT_COPY_FILES += device/zechin/$(MTK_TARGET_PROJECT)/EBR2:EBR2
#endif
#PRODUCT_COPY_FILES += device/zechin/$(MTK_TARGET_PROJECT)/MBR:MBR
#PRODUCT_COPY_FILES += device/zechin/$(MTK_TARGET_PROJECT)/MT6735_Android_scatter.txt:MT6735_Android_scatter.txt

# thermal.conf and thermal_eng.conf:with BCCT 
# thermal_NoBCCT.conf and thermal_eng_NoBCCT.conf:no BCCT 
# thermal policy no BCCT
ifeq ($(TARGET_BUILD_VARIANT),eng)
    PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/thermal_eng.conf:system/etc/.tp/thermal.conf
else
    PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/thermal.conf:system/etc/.tp/thermal.conf
endif
PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/ht120.mtc:system/etc/.tp/.ht120.mtc




# alps/vendor/mediatek/proprietary/external/GeoCoding/Android.mk
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/frameworks/opt/GeoCoding/geocoding.db:system/etc/geocoding.db

# alps/vendor/mediatek/proprietary/frameworks-ext/native/etc/Android.mk
# sensor related xml files for CTS
ifneq ($(strip $(CUSTOM_KERNEL_ACCELEROMETER)),)
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml
endif

ifneq ($(strip $(CUSTOM_KERNEL_MAGNETOMETER)),)
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml
endif

ifneq ($(strip $(CUSTOM_KERNEL_ALSPS)),)
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml
else
  ifneq ($(strip $(CUSTOM_KERNEL_PS)),)
    PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml
  endif
  ifneq ($(strip $(CUSTOM_KERNEL_ALS)),)
    PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml
  endif
endif

ifneq ($(strip $(CUSTOM_KERNEL_GYROSCOPE)),)
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml
endif

ifneq ($(strip $(CUSTOM_KERNEL_BAROMETER)),)
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml
endif

# touch related file for CTS
ifeq ($(strip $(CUSTOM_KERNEL_TOUCHPANEL)),generic)
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml
else
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml
endif

# USB OTG
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml

# GPS relative file
ifeq ($(MTK_GPS_SUPPORT),yes)
  PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml
endif

# alps/external/libnfc-opennfc/open_nfc/hardware/libhardware/modules/nfcc/nfc_hal_microread/Android.mk
# PRODUCT_COPY_FILES += external/libnfc-opennfc/open_nfc/hardware/libhardware/modules/nfcc/nfc_hal_microread/driver/open_nfc_driver.ko:system/lib/open_nfc_driver.ko

# alps/frameworks/av/media/libeffects/factory/Android.mk
PRODUCT_COPY_FILES += frameworks/av/media/libeffects/data/audio_effects.conf:system/etc/audio_effects.conf

# alps/mediatek/config/$project
PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

# alps/mediatek/external/sip/
ifneq ($(MTK_BASIC_PACKAGE),yes)
ifneq ($(MTK_BSP_PACKAGE),yes)
ifeq ($(MTK_SIP_SUPPORT),yes)
  PRODUCT_COPY_FILES += vendor/mediatek/proprietary/external/sip/enable_sip/android.software.sip.xml:system/etc/permissions/android.software.sip.xml
  PRODUCT_COPY_FILES += vendor/mediatek/proprietary/external/sip/enable_sip/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml
else
  PRODUCT_COPY_FILES += vendor/mediatek/proprietary/external/sip/disable_sip/android.software.sip.xml:system/etc/permissions/android.software.sip.xml
  PRODUCT_COPY_FILES += vendor/mediatek/proprietary/external/sip/disable_sip/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml
endif
endif
endif

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.sys.usb.config=mtp
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.service.acm.enable=0
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.mount.fs=EXT4

#PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.heapgrowthlimit=128m
#PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.heapsize=256m

# meta tool
PRODUCT_PROPERTY_OVERRIDES += ro.mediatek.chip_ver=S01
PRODUCT_PROPERTY_OVERRIDES += ro.mediatek.platform=MT6737T

# set Telephony property - SIM count
SIM_COUNT := 2
PRODUCT_PROPERTY_OVERRIDES += ro.telephony.sim.count=$(SIM_COUNT)
PRODUCT_PROPERTY_OVERRIDES += persist.radio.default.sim=0

ifeq ($(GEMINI),yes)
  ifeq ($(MTK_DT_SUPPORT),yes)
    PRODUCT_PROPERTY_OVERRIDES += persist.radio.multisim.config=dsda
  else
    ifeq ($(MTK_SVLTE_SUPPORT),yes)
      PRODUCT_PROPERTY_OVERRIDES += persist.radio.multisim.config=dsda
    else
      PRODUCT_PROPERTY_OVERRIDES += persist.radio.multisim.config=dsds
    endif
  endif
else
  PRODUCT_PROPERTY_OVERRIDES += persist.radio.multisim.config=ss
endif

# Audio Related Resource
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/zechin6737t_35g_m0/factory/res/sound/testpattern1.wav:system/res/sound/testpattern1.wav
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/zechin6737t_35g_m0/factory/res/sound/ringtone.wav:system/res/sound/ringtone.wav

# Keyboard layout
PRODUCT_COPY_FILES += device/mediatek/mt6735/ACCDET.kl:system/usr/keylayout/ACCDET.kl
PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/mtk-kpd.kl:system/usr/keylayout/mtk-kpd.kl

# Microphone
PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/android.hardware.microphone.xml:system/etc/permissions/android.hardware.microphone.xml

# Camera
PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml

# Audio Policy
PRODUCT_COPY_FILES += device/zechin/zechin6737t_35g_m0/audio_policy.conf:system/etc/audio_policy.conf


#Images for LCD test in factory mode
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/zechin6737t_35g_m0/factory/res/images/lcd_test_00.png:system/res/images/lcd_test_00.png
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/zechin6737t_35g_m0/factory/res/images/lcd_test_01.png:system/res/images/lcd_test_01.png
PRODUCT_COPY_FILES += vendor/mediatek/proprietary/custom/zechin6737t_35g_m0/factory/res/images/lcd_test_02.png:system/res/images/lcd_test_02.png


# overlay has priorities. high <-> low.

DEVICE_PACKAGE_OVERLAYS += device/mediatek/common/overlay/sd_in_ex_otg

DEVICE_PACKAGE_OVERLAYS += device/zechin/zechin6737t_35g_m0/overlay
ifdef OPTR_SPEC_SEG_DEF
  ifneq ($(strip $(OPTR_SPEC_SEG_DEF)),NONE)
    OPTR := $(word 1,$(subst _,$(space),$(OPTR_SPEC_SEG_DEF)))
    SPEC := $(word 2,$(subst _,$(space),$(OPTR_SPEC_SEG_DEF)))
    SEG  := $(word 3,$(subst _,$(space),$(OPTR_SPEC_SEG_DEF)))
    DEVICE_PACKAGE_OVERLAYS += device/mediatek/common/overlay/operator/$(OPTR)/$(SPEC)/$(SEG)
  endif
endif
ifneq (yes,$(strip $(MTK_TABLET_PLATFORM)))
  ifeq (480,$(strip $(LCM_WIDTH)))
    ifeq (854,$(strip $(LCM_HEIGHT)))
      DEVICE_PACKAGE_OVERLAYS += device/mediatek/common/overlay/FWVGA
    endif
  endif
  ifeq (540,$(strip $(LCM_WIDTH)))
    ifeq (960,$(strip $(LCM_HEIGHT)))
      DEVICE_PACKAGE_OVERLAYS += device/mediatek/common/overlay/qHD
    endif
  endif
endif
ifeq (yes,$(strip $(MTK_GMO_ROM_OPTIMIZE)))
  DEVICE_PACKAGE_OVERLAYS += device/mediatek/common/overlay/slim_rom
endif
ifeq (yes,$(strip $(MTK_GMO_RAM_OPTIMIZE)))
  DEVICE_PACKAGE_OVERLAYS += device/mediatek/common/overlay/slim_ram
endif
DEVICE_PACKAGE_OVERLAYS += device/mediatek/common/overlay/navbar

ifeq ($(strip $(OPTR_SPEC_SEG_DEF)),NONE)
    PRODUCT_PACKAGES += DangerDash
endif

# inherit 6752 platform
$(call inherit-product, device/mediatek/mt6735/device.mk)

$(call inherit-product-if-exists, vendor/zechin/libs/$(MTK_TARGET_PROJECT)/device-vendor.mk)

# setup dm-verity configs.
PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/platform/mtk-msdc.0/11230000.msdc0/by-name/system
ifneq (yes,$(strip $(MTK_GMO_RAM_OPTIMIZE)))
$(call inherit-product, build/target/product/verity.mk)
endif
