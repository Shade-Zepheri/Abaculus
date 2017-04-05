#include "Main.h"

@implementation ACURootListController

+ (NSString *)hb_specifierPlist {
    return @"Abaculus";
}

- (void)viewDidLoad {
  	[super viewDidLoad];

  	CGRect frame = CGRectMake(0, 0, self.table.bounds.size.width, 127);

  	UIImage *headerImage = [[UIImage alloc]
  		initWithContentsOfFile:[[NSBundle bundleWithPath:@"/Library/PreferenceBundles/Abaculus.bundle"] pathForResource:@"AbaculusHeader" ofType:@"png"]];

  	UIImageView *headerView = [[UIImageView alloc] initWithFrame:frame];
  	[headerView setImage:headerImage];
  	headerView.backgroundColor = [UIColor blackColor];
  	[headerView setContentMode:UIViewContentModeScaleAspectFit];
  	[headerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];

  	self.table.tableHeaderView = headerView;
}

- (void)viewDidLayoutSubviews {
  	[super viewDidLayoutSubviews];

  	CGRect wrapperFrame = ((UIView *)self.table.subviews[0]).frame;
  	CGRect frame = CGRectMake(wrapperFrame.origin.x, self.table.tableHeaderView.frame.origin.y, wrapperFrame.size.width, self.table.tableHeaderView.frame.size.height);

  	self.table.tableHeaderView.frame = frame;
}

- (void)sendEmail {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:ziroalpha@gmail.com?subject=Abaculus"]];
}

@end
