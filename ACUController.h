#import "ACUMenuView.h"

@interface ACUController : NSObject {
    BOOL _isVisible;
    CGPoint _previousLocationInView;
}
@property (nonatomic, strong) ACUMenuView *menuView;
+ (instancetype)sharedInstance;
- (void)fadeMenuIn;
- (void)fadeMenuOutWithCompletion:(void(^)(void))completion;
- (void)_gestureStateChanged:(UIGestureRecognizer*)recognizer;
@end
