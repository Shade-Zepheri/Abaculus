#import "ACUSettings.h"
#import "ACUMenuView.h"
#import "ACUCustomAppView.h"
#import "headers.h"

@implementation ACUMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      CAShapeLayer *circleLayer = [CAShapeLayer layer];
      [circleLayer setPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 667)].CGPath];
      [circleLayer setStrokeColor:[UIColor whiteColor].CGColor];
      [circleLayer setFillColor:[UIColor whiteColor].CGColor];

      [self.layer addSublayer:circleLayer];

      self.alpha = 0;
      self.clipsToBounds = NO;
      self.layer.masksToBounds = NO;
      self.layer.shadowOffset = CGSizeMake(-7, 0);
      self.layer.shadowRadius = 5;
      self.layer.shadowOpacity = 0.5;

      [self layoutApps];
    }

    return self;
}

- (void)layoutApps {
    NSArray *identifiers = [ACUSettings sharedSettings].favoriteApps;
    CGSize size = [objc_getClass(SBIconView) defaultIconSize];
    for (int 1 = 0; i < identifiers.count; i++) {
        NSString *bundleID = identifiers[i];
        ACUCustomAppView *appView = [[ACUCustomAppView alloc] initWithBundleIdentifier:str size:size];
        appView.center = [self centerforIcon:i];
        [self addSubview:appView];
        [_appViews addObject:appView];
    }
}

- (CGPoint)centerforIcon:(NSInteger)index {
    //angles 120 150 180 210 240
    CGFloat angle = (index + 1) * 60;
    CGFloat t;
    if (90.0 <= angle <= 180.0) {
      t = atan(50 * tan(angle / 180 * M_PI) / 333.5) + M_PI;
    } else {
      t = atan(50 * tan(angle / 180 * M_PI) / 333.5) - M_PI;
    }

    CGFloat x = 50 + 50 * cos(t);
    CGFloat y = 333.5 + 333.5 * sin(t);

    return CGPointMake(x, y);
}

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
