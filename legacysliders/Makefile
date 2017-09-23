ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:latest:latest
THEOS_BUILD_DIR = debs

include /var/theos/makefiles/common.mk

TWEAK_NAME = legacysliders
legacysliders_FILES = Tweak.xm
legacysliders_FRAMEWORKS = UIKit CoreGraphics
legacysliders_PRIVATE_FRAMEWORKS = MediaPlayerUI

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
