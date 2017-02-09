#import "ACUController.h"
#import "ACUSettings.h"
#import "ACUWindow.h"
#import "headers.h"

@implementation ACUController

+ (instancetype)sharedInstance {
    static ACUController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isVisible = NO;

        CGRect frame = CGRectMake(kScreenWidth - 50, 0, 50, kScreenHeight);
        _menuView = [[ACUMenuView alloc] initWithFrame:frame];

        _window = [[ACUWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_window addSubview:_menuView];
        HBLogDebug(@"Inited");
    }

    return self;
}

- (void)fadeMenuIn {
  if (_isVisible) {
    return;
  }
  [UIView animateWithDuration:0.3 animations:^{
      _menuView.alpha = 1;
  } completion:^(BOOL finished){
      if (finished) {
        _isVisible = YES;
      }
  }];
}

- (void)fadeMenuOutWithCompletion:(void(^)(void))completion {
  if (!_isVisible) {
    return;
  }

  [UIView animateWithDuration:0.3 animations:^{
      _menuView.alpha = 0;
  } completion:^(BOOL finished){
      if (finished) {
          _isVisible = NO;
          completion();
      }
  }];
}

- (void)_gestureStateChanged:(UIGestureRecognizer*)recognizer {
    if (![ACUSettings sharedSettings].enabled) {
      return;
    }

    CGPoint touchPoint = [recognizer locationInView:recognizer.view];
    if (!CGPointEqualToPoint(touchPoint, CGPointZero)) {
        _previousLocationInView = touchPoint;
    }

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        HBLogDebug(@"Started Gesture");
        [self fadeMenuIn];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        HBLogDebug(@"Gesture Moved");
        [_menuView touchMovedToPoint:touchPoint];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        HBLogDebug(@"Gesture Ended");
        recognizer.enabled = NO;
        recognizer.enabled = YES;

        [self fadeMenuOutWithCompletion:^{
            [_menuView touchEndedAtPoint:_previousLocationInView];
        }];
    }
}

@end
