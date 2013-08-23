TARGET = iphone:clang:latest:5.0

include theos/makefiles/common.mk

TWEAK_NAME = TrackingNotifier
TrackingNotifier_FILES = Tweak.x

BUNDLE_NAME = TrackingNotifierProvider
TrackingNotifierProvider_FILES = TrackingNotifierProvider.m
TrackingNotifierProvider_CFLAGS = -fobjc-arc
TrackingNotifierProvider_FRAMEWORKS = UIKit
TrackingNotifierProvider_PRIVATE_FRAMEWORKS = BulletinBoard
TrackingNotifierProvider_INSTALL_PATH = /Library/WeeLoader/BulletinBoardPlugins

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/bundle.mk
