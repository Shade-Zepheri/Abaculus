#include "Main.h"

@implementation ACURootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Abaculus" target:self];
	}

	return _specifiers;
}

@end
