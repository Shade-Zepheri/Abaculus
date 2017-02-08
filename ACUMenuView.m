#import "ACUSettings.h"
#import "ACUMenuView.h"
#import "ACUCustomAppView.h"
#import "headers.h"

@implementation ACUMenuView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(325,0, 50, 1334)];
    if (self) {
      self.clipsToBounds = NO;

      UIBezierPath *curvePath = [UIBezierPath bezierPath];
      [curvePath moveToPoint:CGPointMake(375,0)];
      [curvePath addCurveToPoint:CGPointMake(375, 1334) controlPoint1:CGPointMake(125, 445) controlPoint2:CGPointMake(125, 889)];

      [self layoutApps]
    }
  //Make Curve with UIBezierPath
}

- (void)layoutApps {
    NSArray *identifiers = [ACUSettings sharedSettings].favoriteApps;
    for (NSString *str in identifiers) {
        ACUCustomAppView *appView = [[ACUCustomAppView alloc] initWithBundleIdentifier:str size:CGSizeMake(40, 40)];
        //appView.center determine where to place along curvePath
        [self addSubview:appView];
        [_appViews addObject:appView];
    }
}

- (CGPoint)centerforIcon {
    //Somehow determine where to place along curvePath;
}

- (void)touchMovedToPoint:(CGPoint)point {
    for (ACUCustomAppView *appView in _appViews) {
        CGRect convertedFrame = [self convertRect:appView.frame fromView:appView.superview];
        if (CGRectContainsPoint(convertedFrame, point)) {
            [appView highlightApp];
        }
        else {
            [appView unhighlightApp];
        }
    }
}
- (void)touchEndedAtPoint:(CGPoint)point {
    for (ACUCustomAppView *appView in _appViews) {
        CGRect convertedFrame = [self convertRect:appView.frame fromView:appView.superview];
        if (appView.isHighlighted) {
            NSString *bundleIdentifier = appView.bundleIdentifier;
            [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleIdentifier suspended:NO];
        }
    }
}

@end
