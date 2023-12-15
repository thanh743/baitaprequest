THEOS_DEVICE_IP = localhost
THEOS_DEVICE_PORT = 2222

TARGET := iphone:clang:15.6:12.4
INSTALL_TARGET_PROCESSES = BaitapLamRequestPOstToserver

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = BaitapLamRequestPOstToserver

BaitapLamRequestPOstToserver_FILES = main.m XXAppDelegate.m ValidateDeviceController.m LFLoginController.m MyTableViewController.m MBProgressHUD.m THRequest.m
BaitapLamRequestPOstToserver_FRAMEWORKS = UIKit CoreGraphics
BaitapLamRequestPOstToserver_CFLAGS = -fobjc-arc -w
BaitapLamRequestPOstToserver_CODESIGN_FLAGS = -Sent.xml
include $(THEOS_MAKE_PATH)/application.mk
