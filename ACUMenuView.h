#import "headers.h"

@interface ACUMenuView : UIView
@property (strong, nonatomic) NSMutableArray *appViews;
@property (strong, nonatomic) CAShapeLayer *circleLayer;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)layoutApps;
- (void)touchMovedToPoint:(CGPoint)point;
- (void)touchEndedAtPoint:(CGPoint)point;
@end
