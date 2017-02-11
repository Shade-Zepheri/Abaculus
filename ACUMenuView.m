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

      _appViews = [[NSMutableArray alloc] init];
    }

    return self;
}

- (NSMutableArray*)appIdentifiers {
    NSMutableArray *appIdentifiers = [[NSMutableArray alloc] init];
    NSMutableArray *oldIdentifiers = [ACUSettings sharedSettings].favoriteApps;
    for (int i = 0; i < [ACUSettings sharedSettings].numberOfApps; i++) {
      NSString *identifier = oldIdentifiers[i];
      [appIdentifiers addObject:identifier];
    }

    return appIdentifiers;
}

- (void)layoutApps {
    NSMutableArray *identifiers = [self appIdentifiers];
    CGSize size = [objc_getClass("SBIconView") defaultIconSize];
    size.height = size.width;
    for (int i = 0; i < identifiers.count; i++) {
      NSString *bundleID = identifiers[i];
      ACUCustomAppView *appView = [[ACUCustomAppView alloc] initWithBundleIdentifier:bundleID size:size];
      NSInteger angle = [self angleForIndex:i];
      appView.center = [self centerforIcon:angle];
      [self addSubview:appView];
      [_appViews addObject:appView];
    }
}

- (NSInteger)angleForIndex:(NSInteger)index {
    CGFloat angle;
    if ([ACUSettings sharedSettings].numberOfApps == 5) {
      //angles 100 110 180 250 260
      switch (index) {
        case 0:
          angle = 97;
          break;
        case 1:
          angle = 110;
          break;
        case 2:
          angle = 180;
          break;
        case 3:
          angle = 250;
          break;
        case 4:
          angle = 263;
          break;
        default:
          angle = 90;
          break;
      }
    } else {
      switch (index) {
        case 0:
          angle = 97;
          break;
        case 1:
          angle = 104;
          break;
        case 2:
          angle = 119;
          break;
        case 3:
          angle = 180;
          break;
        case 4:
          angle = 241;
          break;
        case 5:
          angle = 257;
          break;
        case 6:
          angle = 264;
          break;
        default:
          angle = 90;
          break;
      }
    }

    return angle;
}

- (CGPoint)centerforIcon:(NSInteger)angle {
    CGFloat t = atan(50 * tan(M_PI * angle / 180) / 333.5) - M_PI;

    CGFloat x = 50 + 50 * cos(t);
    CGFloat y = 333.5 + 333.5 * sin(t);

    return CGPointMake(x, y);
}

- (void)touchMovedToPoint:(CGPoint)point {
    for (ACUCustomAppView *appView in _appViews) {
        CGRect convertedFrame = [self convertRect:appView.frame toView:appView.superview.superview];
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
