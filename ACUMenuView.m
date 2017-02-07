#import "ACUSettings.h"
#import "ACUMenuView.h"
#import "headers.h"

@implementation ACUMenuView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(325,0, 50, 1334)];
    if (self) {
      self.clipsToBounds = NO;

      UIBezierPath *curvePath = [UIBezierPath bezierPath];
      [curvePath moveToPoint:CGPointMake(375,0)];
      [curvePath addCurveToPoint:CGPointMake(375, 1334) controlPoint1:CGPointMake(125, 445) controlPoint2:CGPointMake(125, 889)];

      [self ]
    }
  //Make Curve with UIBezierPath
}

- (void)layoutApps {
    NSArray *identifiers = [ACUSettings sharedSettings].favoriteApps;
    for (NSString *str in identifiers) {
      SBApplication *app = [[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:str];
      SBApplicationIcon *icon = [[[[%c(SBIconController) sharedInstance] homescreenIconViewMap] iconModel] applicationIconForBundleIdentifier:app.bundleIdentifier];
      SBIconView *iconView = [[[%c(SBIconController) sharedInstance] homescreenIconViewMap] _iconViewForIcon:icon];
    }
    iconView.frame = CGRectMake(0, 0, 40, 40);
}

- (CGPoint)centerforIcon
