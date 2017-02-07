@interface ACUSettings : NSObject {
    NSDictionary *_settings;
}
@property (nonatomic, assign, readonly) BOOL enabled;
@property (nonatomic, assign, readonly) BOOL showAppLabels;
@property (nonatomic, retain, readonly) NSArray *favoriteApps;
+ (instancetype)sharedSettings;
- (void)reloadSettings;
@end
