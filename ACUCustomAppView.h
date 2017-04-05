@interface ACUCustomAppView : UIView
@property (assign, nonatomic) BOOL isHighlighted;
@property (strong, nonatomic) NSString *bundleIdentifier;
@property (strong, nonatomic) UIView *highlightingView;
- (instancetype)initWithBundleIdentifier:(NSString*)bundleIdentifier size:(CGSize)size;
- (void)highlightApp;
- (void)unhighlightApp;
@end
