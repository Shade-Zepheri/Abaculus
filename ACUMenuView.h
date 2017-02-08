#import "headers.h"

@interface ACUMenuView : UIView {
    NSMutableArray *_appViews;
}
- (instancetype)initWithFrame:(CGRect)frame;
- (void)touchMovedToPoint:(CGPoint)point;
- (void)touchEndedAtPoint:(CGPoint)point;
@end
