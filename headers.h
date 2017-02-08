#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FBSystemGestureManager : NSObject <UIGestureRecognizerDelegate>
+(id)sharedInstance;
-(void)addGestureRecognizer:(id)arg1 toDisplay:(id)arg2;
@end

@interface FBDisplayManager : NSObject
+(id)sharedInstance;
+(id)mainDisplay;
@end

@interface UIApplication (Private)
- (void)launchApplicationWithIdentifier:(NSString*)identifier suspended:(BOOL)suspended;
@end

@interface SBIconModel : NSObject
- (id)applicationIconForBundleIdentifier:(id)arg1;
@end

@interface SBIcon : NSObject
- (UIImage*)generateIconImage:(int)arg1;
@end

@interface SBIconViewMap : NSObject
@property (nonatomic,readonly) SBIconModel * iconModel;
@end

@interface SBIconController : UIViewController
@property (nonatomic,readonly) SBIconViewMap * homescreenIconViewMap;
+ (id)sharedInstance;
@end