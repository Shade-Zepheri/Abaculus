CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Abaculus
Abaculus_FILES = $(wildcard *.m)
Abaculus_INSTALL_PATH = /Library/PreferenceBundles
Abaculus_FRAMEWORKS = UIKit
Abaculus_PRIVATE_FRAMEWORKS = Preferences
Abaculus_EXTRA_FRAMEWORKS = Cephei CepheiPrefs
Abaculus_LIBRARIES = applist

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Abaculus.plist$(ECHO_END)
