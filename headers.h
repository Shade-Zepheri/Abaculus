#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import <SpringBoard/SBApplicationIcon.h>
#import <SpringBoard/SBDisplayItem.h>
#import <SpringBoard/SBIconController.h>
#import <SpringBoard/SBIconModel.h>
#import <SpringBoard/SBMainDisplaySystemGestureManager.h>
#import <SpringBoard/SBScreenEdgePanGestureRecognizer.h>
#import <SpringBoard/SpringBoard.h>
#import <UIKit/UIKit.h>

#define kScreenWidth CGRectGetMaxX([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetMaxY([UIScreen mainScreen].bounds)

@interface SBIcon : NSObject
- (UIImage *)generateIconImage:(int)arg1;
@end

@interface SBIconViewMap : NSObject
@property (nonatomic,readonly) SBIconModel * iconModel;
+ (SBIconViewMap *)switcherMap;
+ (SBIconViewMap *)homescreenMap;
@end

@interface SBIconController ()
@property (nonatomic,readonly) SBIconViewMap * homescreenIconViewMap;
@end

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
