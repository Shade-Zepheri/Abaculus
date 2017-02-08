#import "ACUMenuView.h"

@interface ACUController : NSObject {
    BOOL _isVisible;
    CGPoint _previousLocationInView;
    UIView* _contentViewContainerView;
    UIView* _contentView;
    UIView* _contentViewShadowView;
    CGRect _originalFrame;
}
@property (nonatomic, strong) ACUMenuView *menuView;
+ (instancetype)sharedInstance;
- (void)getContentView;
- (void)getAppContent;
- (void)getSpringBoardContent;
- (void)fadeMenuIn;
- (void)fadeMenuOutWithCompletion:(void(^)(void))completion;
- (void)_gestureStateChanged:(UIGestureRecognizer*)recognizer;
@end
