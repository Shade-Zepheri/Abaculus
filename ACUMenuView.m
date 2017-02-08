#import "ACUSettings.h"
#import "ACUMenuView.h"
#import "ACUCustomAppView.h"
#import "headers.h"

@implementation ACUMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      UIBezierPath *curvePath = [UIBezierPath bezierPath];
      [curvePath moveToPoint:CGPointMake(CGRectGetMaxX([UIScreen mainScreen].bounds), 0)];
      [curvePath addCurveToPoint:CGPointMake(375, 1334) controlPoint1:CGPointMake(125, 445) controlPoint2:CGPointMake(125, 889)];
      UIColor *color = [UIColor whiteColor];
      [color setFill];
      [color setStroke];
      [curvePath fill];
      [curvePath stroke];

      self.clipsToBounds = NO;
      self.alpha = 0;
      self.layer.masksToBounds = NO;
      self.layer.shadowOffset = CGSizeMake(-15, 0);
      self.layer.shadowRadius = 5;
      self.layer.shadowOpacity = 0.5;

      //[self layoutApps]
    }

    return self;
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
 /*
- (CGPoint)centerforIcon {
    //Somehow determine where to place along curvePath;
}
*/
- (void)touchMovedToPoint:(CGPoint)point {
    for (ACUCustomAppView *appView in _appViews) {
        CGRect convertedFrame = [self convertRect:appView.frame fromView:appView.superview];
        if (CGRectContainsPoint(convertedFrame, point)) {
            [appView highlightApp];
        } else {
            [appView unhighlightApp];
        }
    }
}
- (void)touchEndedAtPoint:(CGPoint)point {
    for (ACUCustomAppView *appView in _appViews) {
        if (appView.isHighlighted) {
            NSString *bundleIdentifier = appView.bundleIdentifier;
            [[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleIdentifier suspended:NO];
        }
    }
}

@end
