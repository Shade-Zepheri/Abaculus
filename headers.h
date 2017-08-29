#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import <SpringBoard/SBApplicationIcon.h>
#import <SpringBoard/SBDisplayItem.h>
#import <SpringBoard/SBIconModel.h>
#import <SpringBoard/SBMainDisplaySystemGestureManager.h>
#import <SpringBoard/SBScreenEdgePanGestureRecognizer.h>
#import <SpringBoard/SpringBoard.h>
#import <UIKit/UIKit.h>

#define kScreenWidth CGRectGetMaxX([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetMaxY([UIScreen mainScreen].bounds)

@interface UIWindow (Private)
- (void)_setSecure:(BOOL)secure;
@end

@interface SBIconView : UIView
+ (CGSize)defaultIconSize;
@end

@interface SBAppSwitcherModel : NSObject
+ (instancetype)sharedInstance;
- (NSArray *)mainSwitcherDisplayItems;
@end

@interface UIKeyboard : UIView
+ (id)activeKeyboard;
- (BOOL)isActive;
@end

@interface UIImage (Private)
+ (instancetype)_applicationIconImageForBundleIdentifier:(NSString *)identifier format:(NSInteger)format;
+ (instancetype)_applicationIconImageForBundleIdentifier:(NSString *)identifier format:(NSInteger)format scale:(CGFloat)scale;
+ (instancetype)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
- (instancetype)_applicationIconImageForFormat:(NSInteger)format precomposed:(BOOL)precomposed;
@end
