@interface ACUSettings : NSObject {
    NSDictionary *_settings;
}
@property (nonatomic, assign, readonly) BOOL enabled;
@property (nonatomic, assign, readonly) BOOL showAppLabels;
+ (instancetype)sharedSettings;
- (void)reloadSettings;
- (NSMutableArray*)favoriteApps;
@end
