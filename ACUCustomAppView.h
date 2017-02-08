@interface ACUCustomAppView : UIView {
    UIView *_highlightingView;
}
@property (nonatomic, assign) BOOL isHighlighted;
@property (nonatomic, strong) NSString *bundleIdentifier;
- (instancetype)initWithBundleIdentifier:(NSString*)bundleIdentifier size:(CGSize)size;
- (void)highlightApp;
- (void)unhighlightApp;
@end
