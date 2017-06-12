#define kNoctisAppID CFSTR("com.laughingquoll.noctis")
#define kNoctisEnabledKey CFSTR("LQDDarkModeEnabled")

@interface ACUSettings : NSObject {
    NSDictionary *_settings;
}
@property (assign, readonly, nonatomic) BOOL enabled;
@property (strong, readonly, nonatomic) UIColor *backgroundColor;
@property (assign, readonly, nonatomic) BOOL useNoctis;
@property (assign, readonly, nonatomic) BOOL keyboardDisables;
@property (assign, readonly, nonatomic) NSInteger numberOfApps;
@property (assign, readonly, nonatomic) BOOL useLastApp;
@property (strong, nonatomic) NSMutableArray *favoriteApps;
+ (instancetype)sharedSettings;
+ (BOOL)noctisEnabled;
- (void)reloadSettings;
@end
