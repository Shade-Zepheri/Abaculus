#import "headers.h"
#import "ACUController.h"
#import "ACUSettings.h"

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application {
    %orig;

    UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:[ACUController sharedInstance] action:@selector(_gestureStateChanged:)];
    screenEdgePan.edges = UIRectEdgeRight;
    [[%c(FBSystemGestureManager) sharedInstance] addGestureRecognizer:screenEdgePan toDisplay:[%c(FBDisplayManager) mainDisplay]];
}
%end

void reloadSettings() {
    [[ACUSettings sharedSettings] reloadSettings];
}

%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadSettings, CFSTR("com.shade.abaculus/ReloadPrefs"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
