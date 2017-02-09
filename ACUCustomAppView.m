#import "ACUCustomAppView.h"
#import "ACUSettings.h"
#import "headers.h"

@implementation ACUCustomAppView

- (instancetype)initWithBundleIdentifier:(NSString*)bundleIdentifier size:(CGSize)size {
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self) {
        _bundleIdentifier = bundleIdentifier;
        _isHighlighted = NO;

        SBIcon *icon = [[[[objc_getClass("SBIconController") sharedInstance] homescreenIconViewMap] iconModel] applicationIconForBundleIdentifier:bundleIdentifier];
        UIImage *iconImage = [icon generateIconImage:2];

        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:iconImage];
        iconImageView.frame = self.frame;
        iconImageView.center = self.center;
        [self addSubview:iconImageView];
    }

    return self;
}

- (void)highlightApp {
    if (_isHighlighted) {
        return;
    }

    [UIView animateWithDuration:0.1 animations:^{
        _highlightingView.alpha = 1.0;
    } completion:^(BOOL finished){
        if (finished) {
            _isHighlighted = YES;
        }
    }];
}

- (void)unhighlightApp {
    if (!_isHighlighted) {
        return;
    }

    [UIView animateWithDuration:0.1 animations:^{
        _highlightingView.alpha = 0.0;
    } completion:^(BOOL finished){
        if (finished) {
            _isHighlighted = NO;
        }
    }];
}
@end
