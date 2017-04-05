#import "ACUSettings.h"

@implementation ACUSettings

+ (instancetype)sharedSettings {
    static ACUSettings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

+ (BOOL)noctisEnabled {
    if (![[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/Noctis.dylib"]) {
      return NO;
    }

    CFPreferencesAppSynchronize(kNoctisAppID);
    Boolean valid = NO;
    BOOL noctisEnabled = CFPreferencesGetAppBooleanValue(kNoctisEnabledKey, kNoctisAppID, &valid);

    return valid && noctisEnabled;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self reloadSettings];
    }
    return self;
}

- (void)reloadSettings {
    @autoreleasepool {
        if (_settings) {
            _settings = nil;
        }
        CFPreferencesAppSynchronize(CFSTR("com.shade.abaculus"));
        CFStringRef appID = CFSTR("com.shade.abaculus");
        CFArrayRef keyList = CFPreferencesCopyKeyList(appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);

        BOOL failed = NO;

        if (keyList) {
            _settings = (NSDictionary*)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
            CFRelease(keyList);

            if (!_settings) {
                failed = YES;
            }
        } else {
            failed = YES;
        }
        CFRelease(appID);

        if (failed) {
              _settings = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.shade.abaculus.plist"];
        }

        if (!_settings) {
          HBLogError(@"[ReachApp] could not load settings from CFPreferences or NSDictionary");
        }

        _enabled = ![_settings objectForKey:@"enabled"] ? YES : [[_settings objectForKey:@"enabled"] boolValue];
        _keyboardDisables = ![_settings objectForKey:@"keyboardDisables"] ? YES : [[_settings objectForKey:@"keyboardDisables"] boolValue];
        _numberOfApps = ![_settings objectForKey:@"numberOfApps"] ? 7 : [[_settings objectForKey:@"numberOfApps"] intValue];
        _useLastApp = ![_settings objectForKey:@"lastApp"] ? NO : [[_settings objectForKey:@"lastApp"] boolValue];

        NSMutableArray *favorites = [[NSMutableArray alloc] init];
      	for (NSString *key in _settings.allKeys) {
        		if ([key hasPrefix:@"Favorites-"]) {
          			NSString *ident = [key substringFromIndex:10];
          			if ([_settings[key] boolValue]) {
          				    [favorites addObject:ident];
          			}
        		}
      	}
        _favoriteApps = favorites;
    }
}

@end
