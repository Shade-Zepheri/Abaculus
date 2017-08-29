#import "ACUSettings.h"
#import "ACUMenuView.h"
#import "ACUCustomAppView.h"
#import "headers.h"

@implementation ACUMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIColor *viewColor = [ACUSettings noctisEnabled] ? [UIColor blackColor] :[ACUSettings sharedSettings].backgroundColor;

        self.circleLayer = [CAShapeLayer layer];
        self.circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 667)].CGPath;
        self.circleLayer.strokeColor = viewColor.CGColor;
        self.circleLayer.fillColor = viewColor.CGColor;
        [self.layer addSublayer:self.circleLayer];

        self.alpha = 0;
        self.clipsToBounds = NO;
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(-7, 0);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;

        self.center = CGPointMake(kScreenWidth - 17, kScreenHeight / 2);

        _appViews = [[NSMutableArray alloc] init];

        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(backgroundColorDidChange:) name:@"com.shade.abaculus/BackgroundColorChange" object:nil];
        [center addObserver:self selector:@selector(noctisEnabled:) name:@"com.laughingquoll.noctis.enablenotification" object:nil];
        [center addObserver:self selector:@selector(noctisDisabled:) name:@"com.laughingquoll.noctis.disablenotification" object:nil];
    }

    return self;
}

- (void)backgroundColorDidChange:(NSNotification *)note {
    NSDictionary *colorInfo = [note userInfo];
    UIColor *color = colorInfo[@"backgroundColor"];

    self.circleLayer.strokeColor = color.CGColor;
    self.circleLayer.fillColor = color.CGColor;
}

- (void)noctisEnabled:(NSNotification *)note {
    if (![ACUSettings sharedSettings].useNoctis) {
        return;
    }

    UIColor *color = [UIColor blackColor];

    self.circleLayer.strokeColor = color.CGColor;
    self.circleLayer.fillColor = color.CGColor;
}

- (void)noctisDisabled:(NSNotification *)note {
    if (![ACUSettings sharedSettings].useNoctis) {
        return;
    }

    UIColor *color = [UIColor whiteColor];

    self.circleLayer.strokeColor = color.CGColor;
    self.circleLayer.fillColor = color.CGColor;
}

- (NSMutableArray*)appIdentifiers {
    NSMutableArray *appIdentifiers = [ACUSettings sharedSettings].favoriteApps;

    if ([ACUSettings sharedSettings].useLastApp) {
        if (![appIdentifiers containsObject:[self lastAppBundleIdentifier]] && appIdentifiers.count > 0) {
            [appIdentifiers removeObjectAtIndex:3];
            [appIdentifiers insertObject:[self lastAppBundleIdentifier] atIndex:3];
            return appIdentifiers;
        } else if ([appIdentifiers count] == 0) {
            [appIdentifiers addObject:[self lastAppBundleIdentifier]];
        }
    }

    return appIdentifiers;
}

- (NSString*)lastAppBundleIdentifier {
    NSMutableArray *switcherItems = [[[objc_getClass("SBAppSwitcherModel") sharedInstance] mainSwitcherDisplayItems] mutableCopy];
    if (switcherItems.count < 2) {
        HBLogWarn(@"No Last App, only Current App. Returning Settings as a fallback");
        return @"com.apple.Preferences";
    }

    SBDisplayItem *lastAppItem = switcherItems[1];
    return lastAppItem.displayIdentifier;
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
    NSInteger angle;
    //dont do this kids
    if ([ACUSettings sharedSettings].numberOfApps == 5) {
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
            [(SpringBoard *)[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleIdentifier suspended:NO];
            [_appViews removeAllObjects];
            break;
        }
    }
}

@end
