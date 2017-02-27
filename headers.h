#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kScreenWidth CGRectGetMaxX([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetMaxY([UIScreen mainScreen].bounds)

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
+ (SBIconViewMap *)switcherMap;
+ (SBIconViewMap *)homescreenMap;
@end

@interface SBIconController : UIViewController
@property (nonatomic,readonly) SBIconViewMap * homescreenIconViewMap;
+ (id)sharedInstance;
@end

@interface UIWindow (Private)
- (void)_setSecure:(BOOL)secure;
@end

@interface SBIconView : UIView
+ (CGSize)defaultIconSize;
@end

@interface SBAppSwitcherModel : NSObject
+ (id)sharedInstance;
- (id)mainSwitcherDisplayItems;
@end

@interface SBDisplayItem : NSObject
@property (nonatomic,copy,readonly) NSString * displayIdentifier;
@end
