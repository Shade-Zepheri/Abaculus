#import "ACUController.h"
#import "ACUSettings.h"
#import "ACUWindow.h"
#import "headers.h"

@implementation ACUController

+ (instancetype)sharedInstance {
    static ACUController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isVisible = NO;
        _isFading = NO;

        CGRect frame = CGRectMake(kScreenWidth - 42, 0, 50, kScreenHeight);
        _menuView = [[ACUMenuView alloc] initWithFrame:frame];

        _window = [[ACUWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_window addSubview:_menuView];
    }

    return self;
}

- (void)fadeMenuIn {
    if (_isVisible && _isFading) {
        return;
    }

    [UIView animateWithDuration:0.5 animations:^{
        _menuView.alpha = 1;
        _isFading = YES;
    } completion:^(BOOL finished){
        if (finished) {
          _isVisible = YES;
          _isFading = NO;
        }
    }];
}

- (void)fadeMenuOutWithCompletion:(void(^)(void))completion {
    if (!_isVisible && !_isFading) {
        return;
    }

    [UIView animateWithDuration:0.5 animations:^{
        _menuView.alpha = 0;
        _isFading = YES;
    } completion:^(BOOL finished){
        if (finished) {
            _isFading = NO;
            [_menuView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            _isVisible = NO;
            completion();
        }
    }];
}

- (void)_gestureStateChanged:(UIGestureRecognizer*)recognizer {
    if (![ACUSettings sharedSettings].enabled || ([[UIKeyboard activeKeyboard] isActive] && [ACUSettings sharedSettings].keyboardDisables)) {
        return;
    }

    CGPoint touchPoint = [recognizer locationInView:recognizer.view];
    if (!CGPointEqualToPoint(touchPoint, CGPointZero)) {
        _previousLocationInView = touchPoint;
    }

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [_menuView layoutApps];
        [self fadeMenuIn];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [_menuView touchMovedToPoint:touchPoint];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        recognizer.enabled = NO;
        recognizer.enabled = YES;

        [self fadeMenuOutWithCompletion:^{
            [_menuView touchEndedAtPoint:_previousLocationInView];
        }];
    }
}

@end
