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
	float x, y;
	NSCharacterSet *charset = [NSCharacterSet characterSetWithCharactersInString:@"(,)"];
	NSScanner* scanner = [NSScanner scannerWithString:setting];
	[scanner scanCharactersFromSet: charset intoString: NULL];
	[scanner scanFloat:&x];
	[scanner scanCharactersFromSet: charset intoString: NULL];
	[scanner scanFloat:&y];
	[scanner scanCharactersFromSet: charset intoString: NULL];
	
	return CGPointMake(x,y);
}

@end
