export TARGET = iphone:9.3

CFLAGS = -fobjc-arc

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Abaculus
Abaculus_FILES = Tweak.xm $(wildcard *.m)
Abaculus_FRAMEWORKS = UIKit QuartzCore

SUBPROJECTS = abaculus

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
