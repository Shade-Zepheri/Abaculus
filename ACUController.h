#import "ACUMenuView.h"
#import "ACUWindow.h"

@interface ACUController : NSObject {
    BOOL _isVisible;
    BOOL _isFading;
    CGPoint _previousLocationInView;
}
@property (nonatomic, strong) ACUMenuView *menuView;
@property (nonatomic, strong) ACUWindow *window;
+ (instancetype)sharedInstance;
- (void)fadeMenuIn;
- (void)fadeMenuOutWithCompletion:(void(^)(void))completion;
- (void)_gestureStateChanged:(UIGestureRecognizer*)recognizer;
@end
