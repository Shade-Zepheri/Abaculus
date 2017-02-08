#import "Main.h"

@implementation ACUAboutController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"About" target:self];
	}

	return _specifiers;
}

- (void)openTwitter{
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]]){
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetbot:///user_profile/ShadeZepheri"]];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]]){
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitterrific:///profile?screen_name=ShadeZepheri"]];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]]){
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tweetings:///user?screen_name=ShadeZepheri"]];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]]){
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=ShadeZepheri"]];
	} else{
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://mobile.twitter.com/ShadeZepheri"]];
	}
}

- (void)sendEmail{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:ziroalpha@gmail.com?subject=Abaculus"]];
}

- (void)openGithub {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/Shade-Zepheri/Abaculus"]];
}

@end
