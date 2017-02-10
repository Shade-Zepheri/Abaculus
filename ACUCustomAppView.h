@interface ACUCustomAppView : UIView
@property (nonatomic, assign) BOOL isHighlighted;
@property (nonatomic, strong) NSString *bundleIdentifier;
@property (nonatomic, strong) UIView *highlightingView;
- (instancetype)initWithBundleIdentifier:(NSString*)bundleIdentifier size:(CGSize)size;
- (void)highlightApp;
- (void)unhighlightApp;
@end
