//
//  ZombieUtils.m
//  Zombies
//
//  Created by Nathan Holmberg on 25/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ZombieUtils.h"


@implementation ZombieUtils

+(CGPoint) parseSettingIntoCGPoint:(NSString*) setting
{
	int x, y;
	NSCharacterSet *charset = [NSCharacterSet characterSetWithCharactersInString:@"(,)"];
	NSScanner* scanner = [NSScanner scannerWithString:setting];
	[scanner scanCharactersFromSet: charset intoString: NULL];
	[scanner scanInt:&x];
	[scanner scanCharactersFromSet: charset intoString: NULL];
	[scanner scanInt:&y];
	[scanner scanCharactersFromSet: charset intoString: NULL];
	
	return CGPointMake(x,y);
}

@end
