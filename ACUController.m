#import "ACUController.h"
#import "headers.h"

@implementation ACUController

+ (instancetype)sharedSettings {
    static ACUController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init]
    if (self) {
        _isVisible = NO;
    }

    return self
}

- (void)fadeMenuIn {
  if (_isVisible) {
    return;
  }
  [UIView animateWithDuration:0.7 animations:^{
      _menuView.alpha = 1;
  } completion:^(BOOL finished){
      if (finished) {
        _isVisible = YES;
      }
  }];
}

- (void)fadeOpacityForPosition:(CGPoint)point {
  if ([_menuView.frame containsPoint:point]) {
    return;
  }
  CGFloat x = point.x

}

- (void)fadeMenuOutWithCompletion:(void(^)(void))completion {
  if (!_isVisible) {
    return;
  }

  [UIView animateWithDuration:0.2 delay:0.0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut) animations:^{
      _menuView.alpha = 0;
  } completion:^(BOOL finished){
      if (finished) {
          _isVisible = NO;
          completion();
      }
  }];
}


- (void)_gestureStateChanged:(UIGestureRecognizer*)recognizer {
    CGPoint touchPoint = [recognizer locationInView:recognizer.view];
    if (!CGPointEqualToPoint(touchLocation, CGPointZero)) {
        _previousLocationInView = touchPoint;
    }

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self fadeMenuIn];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self fadeOpacityForPosition:touchPoint]
        [_menuView touchMovedToPoint:touchPoint];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        recognizer.enabled = NO;
        recognizer.enabled = YES;

        [self fadeMenuOutWithCompletion:^{
          [_menuView touchEndedAtPoint:_previousLocationInView];
        }]
    }
}

@end
