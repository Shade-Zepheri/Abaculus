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

- (instancetype)init {
  if ((self = [super init])) {
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
      _settings = [NSDictionary dictionaryWithContentsOfFile:@"/User/Library/Preferences/com.shade.abaculus.plist"];
    }

    if (!_settings) {
      HBLogError(@"[ReachApp] could not load settings from CFPreferences or NSDictionary");
    }

    _enabled = ![_settings objectForKey:@"enabled"] ? YES : [[_settings objectForKey:@"enabled"] boolValue];
    _showAppLabels = ![_settings objectForKey:@"showAppLabels"] ? NO : [[_settings objectForKey:@"showAppLabels"] boolValue];

    NSMutableArray *favorites = [NSMutableArray new];
  	for (NSString *key in [_settings allKeys]) {
  		NSString* prefix = @"Favorites-";
  		if ([key hasPrefix:prefix]) {
  			NSString *trimmedBundleID = [key substringFromIndex:prefix.length];

  			if ([[_settings objectForKey:key] boolValue]) {
  				[favorites addObject:trimmedBundleID];
  			}
  		}
  	}
    _favoriteApps = [NSArray arrayWithArray:favorites];

  }
}

@end
