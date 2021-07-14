TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard
DEBUG=0
FINALPACKAGE=1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = joe

joe_FILES = Joe.xm
joe_CFLAGS = "-fobjc-arc" "-O3"
joe_LDFLAGS = -install_name /Library/MobileSubstrate/DynamicLibraries/joe.dylib
joe_FRAMEWORKS = Foundation UIKit AVKit
joe_LIBRARIES = propr

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += joeprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
