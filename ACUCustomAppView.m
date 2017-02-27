#import "ACUCustomAppView.h"
#import "ACUSettings.h"
#import "headers.h"

@implementation ACUCustomAppView

- (instancetype)initWithBundleIdentifier:(NSString*)bundleIdentifier size:(CGSize)size {
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self) {
        _bundleIdentifier = bundleIdentifier;
        _isHighlighted = NO;

        _highlightingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.height * 0.9, size.height * 0.9)];
        _highlightingView.center = self.center;
        _highlightingView.layer.cornerRadius = 13;
        _highlightingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _highlightingView.alpha = 0;
        [self addSubview:_highlightingView];

        SBIcon *icon = nil;
        if ([objc_getClass("SBIconViewMap") respondsToSelector:@selector(homescreenMap)]) {
    			icon = [[[objc_getClass("SBIconViewMap") homescreenMap] iconModel] applicationIconForBundleIdentifier:bundleIdentifier];
    		} else {
    			icon = [[[[objc_getClass("SBIconController") sharedInstance] homescreenIconViewMap] iconModel] applicationIconForBundleIdentifier:bundleIdentifier];
    		}

        UIImage *iconImage = [icon generateIconImage:2];
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:iconImage];
        iconImageView.frame = CGRectMake(0, 0, size.width * 0.7, size.height * 0.7);
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
