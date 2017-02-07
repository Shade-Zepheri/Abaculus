#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@interface FBSystemGestureManager : NSObject <UIGestureRecognizerDelegate>
+(id)sharedInstance;
-(void)addGestureRecognizer:(id)arg1 toDisplay:(id)arg2;
@end

@interface FBDisplayManager : NSObject
+(id)sharedInstance;
+(id)mainDisplay;
@end
