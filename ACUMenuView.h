#import "headers.h"

@interface ACUMenuView : UIView {
    NSMutableArray *_appViews;
}
- (instancetype)init;
- (void)touchMovedToPoint:(CGPoint)point;
- (void)touchEndedAtPoint:(CGPoint)point;
@end
