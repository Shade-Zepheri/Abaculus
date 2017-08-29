#import "headers.h"
#import "ACUController.h"
#import "ACUSettings.h"

static inline void initializeTweak(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    SBScreenEdgePanGestureRecognizer *recognizer = [[%c(SBScreenEdgePanGestureRecognizer) alloc] initWithTarget:[ACUController sharedInstance] action:@selector(_gestureStateChanged:) type:SBSystemGestureTypeSideAppGrabberReveal];
    recognizer.edges = UIRectEdgeRight;
    [[%c(SBSystemGestureManager) mainDisplayManager] addGestureRecognizer:recognizer withType:51];
}

%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, &initializeTweak, CFSTR("SBSpringBoardDidLaunchNotification"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    [ACUSettings sharedSettings];
}
