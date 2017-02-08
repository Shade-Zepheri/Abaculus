#import "ACUController.h"
#import "ACUSettings.h"
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
        HBLogDebug(@"Inited");
        _isVisible = NO;

        CGFloat x = CGRectGetMaxX([UIScreen mainScreen].bounds) - 50;
        CGRect frame = CGRectMake(x, 0, 50, CGRectGetMaxY([UIScreen mainScreen].bounds));
        _menuView = [[ACUMenuView alloc] initWithFrame:frame];

        [self getContentView];

    }

    return self;
}

- (void)getContentView {
    if (IN_SPRINGBOARD) {
        [self getSpringBoardContent];
    } else {
        [self getAppContent];
    }
}

- (void)getAppContent {
    SBSceneManagerCoordinator *sceneManagerCoordinator = [NSClassFromString(@"SBSceneManagerCoordinator") sharedInstance];
    FBSDisplay *mainDisplay = [NSClassFromString(@"FBDisplayManager") mainDisplay];

    SBMainDisplaySceneManager* sceneManager = [sceneManagerCoordinator sceneManagerForDisplay:mainDisplay];

    SBMainDisplaySceneLayoutViewController* layoutController = [sceneManager layoutController];
    UIViewController* containerViewController = [layoutController _layoutElementControllerForLayoutRole:2];

    //if containerViewController is nil, then that probably means the user was at the homescreen
    //if so, the layout element view controller for that should be the main switcher view controller
    if (!containerViewController) {
        containerViewController = [NSClassFromString(@"SBMainSwitcherViewController") sharedInstance];
    }

    NSLog(@"containerViewController: %@", containerViewController);
    NSLog(@"view: %@", containerViewController.view);

    SBAppContainerView* view = (SBAppContainerView*)[containerViewController view];

    _contentView = view;
}

- (void)getSpringBoardContent {
    SBHomeScreenView* homescreenView = ((SBUIController*)[NSClassFromString(@"SBUIController") sharedInstance]).window;

    _originalFrame = homescreenView.frame;

    UIImageView* copyImageView = [[UIImageView alloc] initWithImage:[SNBMenuController snapshotOfView:homescreenView]];
    UIView* contentView = [[UIView alloc] initWithFrame:copyImageView.frame];
    //the HS screeenshot is transparent
    //so we add the wallpaper before adding the HS screenshot
    /*
    SBWallpaperEffectView* wallpaperView = [[NSClassFromString(@"SBWallpaperEffectView") alloc] initWithWallpaperVariant:0];
    wallpaperView.style = 6;
    wallpaperView.frame = contentView.frame;
    */

    //wallpaperView.alpha = 0;

    //get existing shared wallpaper view, or, homescreen wallpaper view if that doesn't exist
    SBWallpaperController* wallpaperController = [NSClassFromString(@"SBWallpaperController") sharedInstance];
    UIView* wallpaperView = ([wallpaperController valueForKey:@"_sharedWallpaperView"]) ?: [wallpaperController valueForKey:@"_homescreenWallpaperView"];
    UIImageView* wallpaperCopyImageView = [[UIImageView alloc] initWithImage:[SNBMenuController snapshotOfView:wallpaperView]];

    [contentView addSubview:wallpaperCopyImageView];
    [contentView addSubview:copyImageView];

    [homescreenView addSubview:contentView];

    _contentView = contentView;

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
