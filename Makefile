TARGET = iphone:9.3
CFLAGS = -fobjc-arc -O2

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Abaculus
Abaculus_FILES = Tweak.xm $(wildcard *.m)
Abaculus_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += abaculus
include $(THEOS_MAKE_PATH)/aggregate.mk
