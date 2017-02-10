#import "headers.h"

@interface ACUMenuView : UIView
@property (nonatomic, strong) NSMutableArray *appViews;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)touchMovedToPoint:(CGPoint)point;
- (void)touchEndedAtPoint:(CGPoint)point;
@end
