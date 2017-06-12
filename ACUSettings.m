#import "ACUSettings.h"

void reloadSettings(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    [[ACUSettings sharedSettings] reloadSettings];
}

@implementation ACUSettings

+ (instancetype)sharedSettings {
    static ACUSettings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
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
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, reloadSettings, CFSTR("com.shade.abaculus/ReloadPrefs"), NULL, CFNotificationSuspensionBehaviorCoalesce);
        [self reloadSettings];
    }

    return self;
}

- (void)reloadSettings {
    @autoreleasepool {
        _settings = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.shade.abaculus.plist"];

        _enabled = ![_settings objectForKey:@"enabled"] ? YES : [[_settings objectForKey:@"enabled"] boolValue];

        NSInteger colorTag = ![_settings objectForKey:@"backgroundColor"] ? 1 : [[_settings objectForKey:@"backgroundColor"] intValue];
        _backgroundColor = colorTag == 1 ? [UIColor whiteColor] : [UIColor blackColor];
        _useNoctis = ![_settings objectForKey:@"useNoctis"] ? NO : [[_settings objectForKey:@"useNoctis"] boolValue];

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

        NSDictionary *colorInfo = @{@"backgroundColor": _backgroundColor};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.shade.abaculus/BackgroundColorChange" object:nil userInfo:colorInfo];
    }
}

@end
